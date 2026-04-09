package com.acmebank.controller;

import com.acmebank.util.DbHelper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class AccountController {

    private static final Logger log = Logger.getLogger(AccountController.class);
    private Gson gson = new Gson();

    @Autowired
    private JdbcTemplate jdbc;

    // get all accts
    @RequestMapping(value = "/accounts", method = RequestMethod.GET)
    public String getAll(HttpServletRequest req) {
        String type = req.getParameter("type");
        String sql = "SELECT * FROM ACCOUNTS";
        if (type != null && !type.isEmpty()) {
            sql = sql + " WHERE ACCT_TYPE = '" + type + "'";
        }
        List<Map<String, Object>> rows = jdbc.queryForList(sql);
        JsonArray arr = new JsonArray();
        for (Map<String, Object> r : rows) {
            JsonObject o = new JsonObject();
            o.addProperty("id", (Long) r.get("ID"));
            o.addProperty("acctNum", (String) r.get("ACCT_NUM"));
            o.addProperty("custId", (Long) r.get("CUST_ID"));
            o.addProperty("type", (String) r.get("ACCT_TYPE"));
            o.addProperty("bal", ((BigDecimal) r.get("BALANCE")).doubleValue());
            o.addProperty("status", (String) r.get("STATUS"));
            o.addProperty("openDt", r.get("OPEN_DATE").toString());
            // interest rate -- only for savings
            if ("SAV".equals(r.get("ACCT_TYPE"))) {
                o.addProperty("intRate", ((BigDecimal) r.get("INT_RATE")).doubleValue());
            }
            arr.add(o);
        }
        return arr.toString();
    }

    // create acct
    @RequestMapping(value = "/accounts", method = RequestMethod.POST)
    public String createAcct(HttpServletRequest req, HttpServletResponse resp) {
        try {
            BufferedReader br = req.getReader();
            StringBuilder sb = new StringBuilder();
            String ln;
            while ((ln = br.readLine()) != null) sb.append(ln);
            JsonObject body = gson.fromJson(sb.toString(), JsonObject.class);

            String acctNum = "ACB-" + System.currentTimeMillis();
            long custId = body.get("custId").getAsLong();
            String type = body.get("type").getAsString();
            double initBal = body.has("initialBalance") ? body.get("initialBalance").getAsDouble() : 0.0;
            double intRate = 0.0;

            // biz rule: minimum balance for different account types
            if ("CHK".equals(type) && initBal < 100) {
                resp.setStatus(400);
                return "{\"error\":\"Checking accounts require minimum $100\"}";
            }
            if ("SAV".equals(type)) {
                if (initBal < 500) {
                    resp.setStatus(400);
                    return "{\"error\":\"Savings accounts require minimum $500\"}";
                }
                intRate = 0.025; // standard savings rate
                // premium rate for high-value accounts
                if (initBal >= 50000) intRate = 0.035;
                if (initBal >= 100000) intRate = 0.045;
            }

            // check if customer exists
            List<Map<String, Object>> cust = jdbc.queryForList(
                "SELECT * FROM CUSTOMERS WHERE ID = " + custId);
            if (cust.isEmpty()) {
                resp.setStatus(404);
                return "{\"error\":\"Customer not found\"}";
            }

            // max 5 accounts per customer -- added by JR 2019-03-15
            List<Map<String, Object>> existing = jdbc.queryForList(
                "SELECT COUNT(*) as CNT FROM ACCOUNTS WHERE CUST_ID = " + custId);
            long cnt = (Long) existing.get(0).get("CNT");
            if (cnt >= 5) {
                resp.setStatus(400);
                return "{\"error\":\"Maximum 5 accounts per customer\"}";
            }

            jdbc.update("INSERT INTO ACCOUNTS (ACCT_NUM, CUST_ID, ACCT_TYPE, BALANCE, INT_RATE, STATUS, OPEN_DATE) " +
                "VALUES (?, ?, ?, ?, ?, 'ACTIVE', CURRENT_TIMESTAMP)",
                acctNum, custId, type, initBal, intRate);

            // log the transaction
            jdbc.update("INSERT INTO TXNLOG (ACCT_NUM, TXN_TYPE, AMOUNT, BAL_AFTER, TXN_DATE, DESCRIPTION) " +
                "VALUES (?, 'OPEN', ?, ?, CURRENT_TIMESTAMP, ?)",
                acctNum, initBal, initBal, "Account opened - " + type);

            resp.setStatus(201);
            JsonObject result = new JsonObject();
            result.addProperty("acctNum", acctNum);
            result.addProperty("status", "ACTIVE");
            return result.toString();
        } catch (Exception e) {
            log.error("Error creating account", e);
            resp.setStatus(500);
            return "{\"error\":\"Internal error\"}";
        }
    }

    // transfer between accounts
    @RequestMapping(value = "/transfer", method = RequestMethod.POST)
    public String transfer(HttpServletRequest req, HttpServletResponse resp) {
        try {
            BufferedReader br = req.getReader();
            StringBuilder sb = new StringBuilder();
            String ln;
            while ((ln = br.readLine()) != null) sb.append(ln);
            JsonObject body = gson.fromJson(sb.toString(), JsonObject.class);

            String fromAcct = body.get("from").getAsString();
            String toAcct = body.get("to").getAsString();
            double amt = body.get("amount").getAsDouble();

            if (amt <= 0) {
                resp.setStatus(400);
                return "{\"error\":\"Amount must be positive\"}";
            }

            // get source account
            List<Map<String, Object>> src = jdbc.queryForList(
                "SELECT * FROM ACCOUNTS WHERE ACCT_NUM = '" + fromAcct + "'");
            if (src.isEmpty()) {
                resp.setStatus(404);
                return "{\"error\":\"Source account not found\"}";
            }

            // get dest account
            List<Map<String, Object>> dst = jdbc.queryForList(
                "SELECT * FROM ACCOUNTS WHERE ACCT_NUM = '" + toAcct + "'");
            if (dst.isEmpty()) {
                resp.setStatus(404);
                return "{\"error\":\"Destination account not found\"}";
            }

            Map<String, Object> srcAcct = src.get(0);
            Map<String, Object> dstAcct = dst.get(0);

            // check status
            if (!"ACTIVE".equals(srcAcct.get("STATUS")) || !"ACTIVE".equals(dstAcct.get("STATUS"))) {
                resp.setStatus(400);
                return "{\"error\":\"Both accounts must be active\"}";
            }

            double srcBal = ((BigDecimal) srcAcct.get("BALANCE")).doubleValue();

            // biz rule: daily transfer limit is $10,000
            // TODO: this doesn't actually check daily total, just per-txn -- fix later
            if (amt > 10000) {
                resp.setStatus(400);
                return "{\"error\":\"Transfer limit exceeded\"}";
            }

            if (srcBal < amt) {
                resp.setStatus(400);
                return "{\"error\":\"Insufficient funds\"}";
            }

            double newSrcBal = srcBal - amt;
            double newDstBal = ((BigDecimal) dstAcct.get("BALANCE")).doubleValue() + amt;

            // update balances -- no real transaction isolation here (known issue)
            jdbc.update("UPDATE ACCOUNTS SET BALANCE = ? WHERE ACCT_NUM = ?", newSrcBal, fromAcct);
            jdbc.update("UPDATE ACCOUNTS SET BALANCE = ? WHERE ACCT_NUM = ?", newDstBal, toAcct);

            // log both sides
            jdbc.update("INSERT INTO TXNLOG (ACCT_NUM, TXN_TYPE, AMOUNT, BAL_AFTER, TXN_DATE, DESCRIPTION) " +
                "VALUES (?, 'XFER_OUT', ?, ?, CURRENT_TIMESTAMP, ?)",
                fromAcct, amt, newSrcBal, "Transfer to " + toAcct);
            jdbc.update("INSERT INTO TXNLOG (ACCT_NUM, TXN_TYPE, AMOUNT, BAL_AFTER, TXN_DATE, DESCRIPTION) " +
                "VALUES (?, 'XFER_IN', ?, ?, CURRENT_TIMESTAMP, ?)",
                toAcct, amt, newDstBal, "Transfer from " + fromAcct);

            JsonObject result = new JsonObject();
            result.addProperty("status", "completed");
            result.addProperty("fromBal", newSrcBal);
            result.addProperty("toBal", newDstBal);
            return result.toString();
        } catch (Exception e) {
            log.error("Transfer failed", e);
            resp.setStatus(500);
            return "{\"error\":\"Internal error\"}";
        }
    }

    // interest calc -- runs monthly, called from batch endpoint
    @RequestMapping(value = "/batch/interest", method = RequestMethod.POST)
    public String calcInterest(HttpServletResponse resp) {
        try {
            List<Map<String, Object>> savAccts = jdbc.queryForList(
                "SELECT * FROM ACCOUNTS WHERE ACCT_TYPE = 'SAV' AND STATUS = 'ACTIVE'");
            int processed = 0;
            for (Map<String, Object> a : savAccts) {
                double bal = ((BigDecimal) a.get("BALANCE")).doubleValue();
                double rate = ((BigDecimal) a.get("INT_RATE")).doubleValue();
                // monthly interest = balance * (annual_rate / 12)
                // rounded to 2 decimal places
                double interest = new BigDecimal(bal * (rate / 12.0))
                    .setScale(2, RoundingMode.HALF_UP).doubleValue();
                if (interest > 0) {
                    double newBal = bal + interest;
                    jdbc.update("UPDATE ACCOUNTS SET BALANCE = ? WHERE ACCT_NUM = ?",
                        newBal, a.get("ACCT_NUM"));
                    jdbc.update("INSERT INTO TXNLOG (ACCT_NUM, TXN_TYPE, AMOUNT, BAL_AFTER, TXN_DATE, DESCRIPTION) " +
                        "VALUES (?, 'INT', ?, ?, CURRENT_TIMESTAMP, ?)",
                        a.get("ACCT_NUM"), interest, newBal, "Monthly interest at " + (rate * 100) + "%");
                    processed++;
                }
            }
            return "{\"processed\":" + processed + "}";
        } catch (Exception e) {
            log.error("Interest calc failed", e);
            resp.setStatus(500);
            return "{\"error\":\"Batch failed\"}";
        }
    }

    // acct statement -- quick and dirty, returns all txns
    @RequestMapping(value = "/accounts/{acctNum}/statement", method = RequestMethod.GET)
    public String getStatement(@PathVariable String acctNum, HttpServletRequest req) {
        String from = req.getParameter("from");
        String to = req.getParameter("to");
        String sql = "SELECT * FROM TXNLOG WHERE ACCT_NUM = '" + acctNum + "'";
        if (from != null) sql += " AND TXN_DATE >= '" + from + "'";
        if (to != null) sql += " AND TXN_DATE <= '" + to + "'";
        sql += " ORDER BY TXN_DATE DESC";
        List<Map<String, Object>> rows = jdbc.queryForList(sql);
        return gson.toJson(rows);
    }
}
