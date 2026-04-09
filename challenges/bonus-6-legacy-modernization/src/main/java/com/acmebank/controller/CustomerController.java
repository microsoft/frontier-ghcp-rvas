package com.acmebank.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.*;

@RestController
public class CustomerController {

    private static final Logger log = Logger.getLogger(CustomerController.class);
    private Gson gson = new Gson();

    @Autowired
    private JdbcTemplate jdbc;

    @RequestMapping(value = "/customers", method = RequestMethod.GET)
    public String list(HttpServletRequest req) {
        String q = req.getParameter("q");
        String sql = "SELECT * FROM CUSTOMERS";
        if (q != null && !q.isEmpty()) {
            // search by name or email
            sql += " WHERE UPPER(FIRST_NAME) LIKE '%" + q.toUpperCase() + "%'"
                + " OR UPPER(LAST_NAME) LIKE '%" + q.toUpperCase() + "%'"
                + " OR UPPER(EMAIL) LIKE '%" + q.toUpperCase() + "%'";
        }
        List<Map<String, Object>> rows = jdbc.queryForList(sql);
        JsonArray arr = new JsonArray();
        for (Map<String, Object> r : rows) {
            JsonObject o = new JsonObject();
            o.addProperty("id", (Long) r.get("ID"));
            o.addProperty("fn", (String) r.get("FIRST_NAME"));
            o.addProperty("ln", (String) r.get("LAST_NAME"));
            o.addProperty("email", (String) r.get("EMAIL"));
            o.addProperty("phone", (String) r.get("PHONE"));
            o.addProperty("addr", (String) r.get("ADDRESS"));
            o.addProperty("tier", (String) r.get("CUST_TIER"));
            o.addProperty("regDt", r.get("REG_DATE").toString());
            arr.add(o);
        }
        return arr.toString();
    }

    @RequestMapping(value = "/customers/{id}", method = RequestMethod.GET)
    public String get(@PathVariable long id, HttpServletResponse resp) {
        List<Map<String, Object>> rows = jdbc.queryForList(
            "SELECT * FROM CUSTOMERS WHERE ID = " + id);
        if (rows.isEmpty()) {
            resp.setStatus(404);
            return "{\"error\":\"Not found\"}";
        }
        Map<String, Object> r = rows.get(0);
        JsonObject o = new JsonObject();
        o.addProperty("id", (Long) r.get("ID"));
        o.addProperty("fn", (String) r.get("FIRST_NAME"));
        o.addProperty("ln", (String) r.get("LAST_NAME"));
        o.addProperty("email", (String) r.get("EMAIL"));
        o.addProperty("phone", (String) r.get("PHONE"));
        o.addProperty("addr", (String) r.get("ADDRESS"));
        o.addProperty("tier", (String) r.get("CUST_TIER"));

        // get accounts for this customer
        List<Map<String, Object>> accts = jdbc.queryForList(
            "SELECT * FROM ACCOUNTS WHERE CUST_ID = " + id);
        JsonArray acctArr = new JsonArray();
        for (Map<String, Object> a : accts) {
            JsonObject ao = new JsonObject();
            ao.addProperty("acctNum", (String) a.get("ACCT_NUM"));
            ao.addProperty("type", (String) a.get("ACCT_TYPE"));
            ao.addProperty("bal", a.get("BALANCE").toString());
            ao.addProperty("status", (String) a.get("STATUS"));
            acctArr.add(ao);
        }
        o.add("accounts", acctArr);

        return o.toString();
    }

    @RequestMapping(value = "/customers", method = RequestMethod.POST)
    public String create(HttpServletRequest req, HttpServletResponse resp) {
        try {
            BufferedReader br = req.getReader();
            StringBuilder sb = new StringBuilder();
            String ln;
            while ((ln = br.readLine()) != null) sb.append(ln);
            JsonObject body = gson.fromJson(sb.toString(), JsonObject.class);

            String fn = body.get("firstName").getAsString();
            String lastn = body.get("lastName").getAsString();
            String email = body.get("email").getAsString();

            // check for duplicate email
            List<Map<String, Object>> dup = jdbc.queryForList(
                "SELECT * FROM CUSTOMERS WHERE EMAIL = '" + email + "'");
            if (!dup.isEmpty()) {
                resp.setStatus(409);
                return "{\"error\":\"Email already registered\"}";
            }

            String phone = body.has("phone") ? body.get("phone").getAsString() : "";
            String addr = body.has("address") ? body.get("address").getAsString() : "";

            // tier assignment: all new customers start as STANDARD
            // upgraded to GOLD at $50k total balance, PLATINUM at $250k
            // (tier update happens in the batch job, not here)
            jdbc.update("INSERT INTO CUSTOMERS (FIRST_NAME, LAST_NAME, EMAIL, PHONE, ADDRESS, CUST_TIER, REG_DATE) " +
                "VALUES (?, ?, ?, ?, ?, 'STANDARD', CURRENT_TIMESTAMP)",
                fn, lastn, email, phone, addr);

            resp.setStatus(201);
            return "{\"status\":\"created\"}";
        } catch (Exception e) {
            log.error("Error creating customer", e);
            resp.setStatus(500);
            return "{\"error\":\"Internal error\"}";
        }
    }

    // update tier based on total balance -- called from batch
    @RequestMapping(value = "/batch/tiers", method = RequestMethod.POST)
    public String updateTiers(HttpServletResponse resp) {
        try {
            List<Map<String, Object>> custs = jdbc.queryForList("SELECT * FROM CUSTOMERS");
            int updated = 0;
            for (Map<String, Object> c : custs) {
                long custId = (Long) c.get("ID");
                // sum all account balances
                List<Map<String, Object>> balResult = jdbc.queryForList(
                    "SELECT COALESCE(SUM(BALANCE), 0) as TOTAL FROM ACCOUNTS WHERE CUST_ID = " + custId + " AND STATUS = 'ACTIVE'");
                double total = ((java.math.BigDecimal) balResult.get(0).get("TOTAL")).doubleValue();
                String newTier;
                if (total >= 250000) newTier = "PLATINUM";
                else if (total >= 50000) newTier = "GOLD";
                else newTier = "STANDARD";

                String currentTier = (String) c.get("CUST_TIER");
                if (!newTier.equals(currentTier)) {
                    jdbc.update("UPDATE CUSTOMERS SET CUST_TIER = ? WHERE ID = ?", newTier, custId);
                    updated++;
                }
            }
            return "{\"updated\":" + updated + "}";
        } catch (Exception e) {
            log.error("Tier update failed", e);
            resp.setStatus(500);
            return "{\"error\":\"Batch failed\"}";
        }
    }
}
