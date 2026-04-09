package com.widgetcorp.api;

import com.widgetcorp.domain.Order;
import com.widgetcorp.domain.OrderLine;
import com.widgetcorp.domain.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    @Autowired
    private JdbcTemplate jdbc;

    @GetMapping
    public List<Map<String, Object>> listOrders(@RequestParam(required = false) String status,
                                                 @RequestParam(required = false) Long customerId) {
        StringBuilder sql = new StringBuilder("SELECT * FROM ORDERS WHERE 1=1");
        if (status != null) sql.append(" AND STATUS = '").append(status).append("'");
        if (customerId != null) sql.append(" AND CUSTOMER_ID = ").append(customerId);
        sql.append(" ORDER BY CREATED_AT DESC");
        return jdbc.queryForList(sql.toString());
    }

    @PostMapping
    public Map<String, Object> createOrder(@RequestBody Map<String, Object> body) {
        String orderNum = "ORD-" + System.currentTimeMillis();
        Long customerId = ((Number) body.get("customerId")).longValue();
        String shipAddr = (String) body.get("shippingAddress");
        String billAddr = (String) body.get("billingAddress");

        @SuppressWarnings("unchecked")
        List<Map<String, Object>> items = (List<Map<String, Object>>) body.get("items");

        double subtotal = 0;
        List<Map<String, Object>> processedLines = new ArrayList<>();

        for (Map<String, Object> item : items) {
            String sku = (String) item.get("sku");
            int qty = ((Number) item.get("quantity")).intValue();

            // look up product for current price and stock
            List<Map<String, Object>> products = jdbc.queryForList(
                "SELECT * FROM PRODUCTS WHERE SKU = '" + sku + "'");
            if (products.isEmpty()) {
                throw new RuntimeException("Product not found: " + sku);
            }
            Map<String, Object> product = products.get(0);
            double unitPrice = ((Number) product.get("PRICE")).doubleValue();
            int stock = ((Number) product.get("STOCK_QTY")).intValue();

            if (stock < qty) {
                throw new RuntimeException("Insufficient stock for " + sku);
            }

            // volume discount: 10+ items get 5%, 50+ get 10%, 100+ get 15%
            double discount = 0;
            if (qty >= 100) discount = 0.15;
            else if (qty >= 50) discount = 0.10;
            else if (qty >= 10) discount = 0.05;

            double lineTotal = qty * unitPrice * (1 - discount);
            subtotal += lineTotal;

            // deduct stock
            jdbc.update("UPDATE PRODUCTS SET STOCK_QTY = STOCK_QTY - ? WHERE SKU = ?", qty, sku);

            Map<String, Object> line = new HashMap<>();
            line.put("sku", sku);
            line.put("productName", product.get("NAME"));
            line.put("quantity", qty);
            line.put("unitPrice", unitPrice);
            line.put("discount", discount * 100);
            line.put("lineTotal", lineTotal);
            processedLines.add(line);
        }

        // tax calculation: 23% VAT
        double tax = subtotal * 0.23;
        // shipping: free above 500, otherwise 12.50 flat
        double shipping = subtotal >= 500 ? 0 : 12.50;
        double total = subtotal + tax + shipping;

        jdbc.update("INSERT INTO ORDERS (ORDER_NUMBER, CUSTOMER_ID, STATUS, SUBTOTAL, TAX_AMOUNT, " +
            "SHIPPING_COST, TOTAL_AMOUNT, SHIPPING_ADDRESS, BILLING_ADDRESS, CREATED_AT, UPDATED_AT) " +
            "VALUES (?, ?, 'PENDING', ?, ?, ?, ?, ?, ?, NOW(), NOW())",
            orderNum, customerId, subtotal, tax, shipping, total, shipAddr, billAddr);

        // get the order ID back
        Long orderId = jdbc.queryForObject("SELECT ID FROM ORDERS WHERE ORDER_NUMBER = ?",
            Long.class, orderNum);

        for (Map<String, Object> line : processedLines) {
            jdbc.update("INSERT INTO ORDER_LINES (ORDER_ID, PRODUCT_SKU, PRODUCT_NAME, QUANTITY, " +
                "UNIT_PRICE, LINE_TOTAL, DISCOUNT_PERCENT) VALUES (?, ?, ?, ?, ?, ?, ?)",
                orderId, line.get("sku"), line.get("productName"), line.get("quantity"),
                line.get("unitPrice"), line.get("lineTotal"), line.get("discount"));
        }

        Map<String, Object> result = new HashMap<>();
        result.put("orderNumber", orderNum);
        result.put("status", "PENDING");
        result.put("total", total);
        result.put("lines", processedLines);
        return result;
    }

    // State transitions: PENDING->CONFIRMED->SHIPPED->DELIVERED
    //                    PENDING->CANCELLED
    //                    DELIVERED->RETURNED (within 30 days)
    @PutMapping("/{orderNum}/status")
    public Map<String, Object> updateStatus(@PathVariable String orderNum,
                                             @RequestBody Map<String, String> body) {
        String newStatus = body.get("status");
        List<Map<String, Object>> orders = jdbc.queryForList(
            "SELECT * FROM ORDERS WHERE ORDER_NUMBER = ?", orderNum);
        if (orders.isEmpty()) {
            throw new RuntimeException("Order not found");
        }

        String current = (String) orders.get(0).get("STATUS");

        // validate transitions
        boolean valid = false;
        if ("PENDING".equals(current) && ("CONFIRMED".equals(newStatus) || "CANCELLED".equals(newStatus))) valid = true;
        if ("CONFIRMED".equals(current) && "SHIPPED".equals(newStatus)) valid = true;
        if ("SHIPPED".equals(current) && "DELIVERED".equals(newStatus)) valid = true;
        if ("DELIVERED".equals(current) && "RETURNED".equals(newStatus)) valid = true;

        if (!valid) {
            throw new RuntimeException("Invalid transition from " + current + " to " + newStatus);
        }

        // on cancellation, restock items
        if ("CANCELLED".equals(newStatus)) {
            Long orderId = ((Number) orders.get(0).get("ID")).longValue();
            List<Map<String, Object>> lines = jdbc.queryForList(
                "SELECT * FROM ORDER_LINES WHERE ORDER_ID = ?", orderId);
            for (Map<String, Object> line : lines) {
                jdbc.update("UPDATE PRODUCTS SET STOCK_QTY = STOCK_QTY + ? WHERE SKU = ?",
                    line.get("QUANTITY"), line.get("PRODUCT_SKU"));
            }
        }

        jdbc.update("UPDATE ORDERS SET STATUS = ?, UPDATED_AT = NOW() WHERE ORDER_NUMBER = ?",
            newStatus, orderNum);

        Map<String, Object> result = new HashMap<>();
        result.put("orderNumber", orderNum);
        result.put("previousStatus", current);
        result.put("newStatus", newStatus);
        return result;
    }
}
