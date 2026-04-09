package com.acmebank.util;

import org.apache.log4j.Logger;

import java.text.SimpleDateFormat;
import java.util.Date;

// utility stuff -- added over time by different people
public class DbHelper {

    private static final Logger log = Logger.getLogger(DbHelper.class);

    // formats for display
    public static String fmtDate(Date d) {
        return new SimpleDateFormat("yyyy-MM-dd").format(d);
    }

    public static String fmtDateTime(Date d) {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
    }

    // generate a reference number for txns
    // format: TXN-YYYYMMDD-XXXXX (X = random digits)
    public static String genTxnRef() {
        String dt = new SimpleDateFormat("yyyyMMdd").format(new Date());
        int rand = (int) (Math.random() * 99999);
        return String.format("TXN-%s-%05d", dt, rand);
    }

    // mask account number for display (show last 4)
    public static String maskAcct(String acctNum) {
        if (acctNum == null || acctNum.length() < 4) return "****";
        return "****" + acctNum.substring(acctNum.length() - 4);
    }

    // validate email -- very basic, should use regex
    public static boolean isValidEmail(String email) {
        return email != null && email.contains("@") && email.contains(".");
    }

    // phone formatting -- strips non-digits then formats
    // only handles US numbers, breaks on international
    public static String fmtPhone(String phone) {
        if (phone == null) return "";
        String digits = phone.replaceAll("[^0-9]", "");
        if (digits.length() == 10) {
            return "(" + digits.substring(0, 3) + ") " + digits.substring(3, 6) + "-" + digits.substring(6);
        }
        return phone; // give up
    }

    // this was supposed to send notifications but never got implemented
    // leaving the stub because CustomerController references it in a comment
    public static void sendNotification(String to, String msg) {
        log.info("NOTIFICATION STUB: would send to " + to + ": " + msg);
        // TODO: integrate with email service
    }
}
