package com.acmebank.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

@RestController
public class ReportController {

    private static final Logger log = Logger.getLogger(ReportController.class);
    private Gson gson = new Gson();

    @Autowired
    private JdbcTemplate jdbc;

    // portfolio summary for a customer
    @RequestMapping(value = "/reports/portfolio/{custId}", method = RequestMethod.GET)
    public String portfolio(@PathVariable long custId, HttpServletResponse resp) {
        List<Map<String, Object>> cust = jdbc.queryForList(
            "SELECT * FROM CUSTOMERS WHERE ID = " + custId);
        if (cust.isEmpty()) {
            resp.setStatus(404);
            return "{\"error\":\"Customer not found\"}";
        }

        List<Map<String, Object>> accts = jdbc.queryForList(
            "SELECT * FROM ACCOUNTS WHERE CUST_ID = " + custId + " AND STATUS = 'ACTIVE'");

        double totalBal = 0;
        int chkCount = 0, savCount = 0, fdCount = 0;
        double chkBal = 0, savBal = 0, fdBal = 0;

        for (Map<String, Object> a : accts) {
            double bal = ((BigDecimal) a.get("BALANCE")).doubleValue();
            String type = (String) a.get("ACCT_TYPE");
            totalBal += bal;
            if ("CHK".equals(type)) { chkCount++; chkBal += bal; }
            else if ("SAV".equals(type)) { savCount++; savBal += bal; }
            else if ("FD".equals(type)) { fdCount++; fdBal += bal; }
        }

        JsonObject result = new JsonObject();
        result.addProperty("customerId", custId);
        result.addProperty("name", cust.get(0).get("FIRST_NAME") + " " + cust.get(0).get("LAST_NAME"));
        result.addProperty("tier", (String) cust.get(0).get("CUST_TIER"));
        result.addProperty("totalBalance", totalBal);
        result.addProperty("checkingAccounts", chkCount);
        result.addProperty("checkingBalance", chkBal);
        result.addProperty("savingsAccounts", savCount);
        result.addProperty("savingsBalance", savBal);
        result.addProperty("fixedDepositAccounts", fdCount);
        result.addProperty("fixedDepositBalance", fdBal);

        return result.toString();
    }

    // daily summary report
    @RequestMapping(value = "/reports/daily", method = RequestMethod.GET)
    public String dailySummary() {
        // WARNING: this query uses string concat for dates which is fragile
        // it was fine in the old Oracle DB but H2 handles dates differently
        // temporary fix: just get all txns from today -- PM 2022-01-10
        List<Map<String, Object>> txns = jdbc.queryForList(
            "SELECT * FROM TXNLOG WHERE CAST(TXN_DATE AS DATE) = CURRENT_DATE");

        double totalDeposits = 0, totalWithdrawals = 0, totalTransfers = 0;
        int txnCount = txns.size();

        for (Map<String, Object> t : txns) {
            String type = (String) t.get("TXN_TYPE");
            double amt = ((BigDecimal) t.get("AMOUNT")).doubleValue();
            if ("DEP".equals(type)) totalDeposits += amt;
            else if ("WDR".equals(type)) totalWithdrawals += amt;
            else if ("XFER_OUT".equals(type)) totalTransfers += amt;
        }

        JsonObject result = new JsonObject();
        result.addProperty("date", new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        result.addProperty("transactionCount", txnCount);
        result.addProperty("totalDeposits", totalDeposits);
        result.addProperty("totalWithdrawals", totalWithdrawals);
        result.addProperty("totalTransfers", totalTransfers);

        return result.toString();
    }

    // fetch exchange rates from external service (for cross-currency accounts)
    // NOTE: this was added in 2018 for the cross-border pilot but the pilot
    //       was cancelled. The endpoint still works but nobody uses it.
    //       leaving it because removing things always breaks something -- PM
    @RequestMapping(value = "/rates", method = RequestMethod.GET)
    public String getExchangeRates(HttpServletResponse resp) {
        CloseableHttpClient client = null;
        try {
            client = HttpClients.createDefault();
            HttpGet get = new HttpGet("https://api.exchangerate-api.com/v4/latest/USD");
            CloseableHttpResponse response = client.execute(get);
            String body = EntityUtils.toString(response.getEntity());
            response.close();
            return body;
        } catch (Exception e) {
            log.error("Failed to fetch rates", e);
            resp.setStatus(503);
            return "{\"error\":\"Rate service unavailable\"}";
        } finally {
            try { if (client != null) client.close(); } catch (Exception e) { }
        }
    }
}
