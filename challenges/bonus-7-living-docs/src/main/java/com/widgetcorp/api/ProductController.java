package com.widgetcorp.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private JdbcTemplate jdbc;

    @GetMapping
    public List<Map<String, Object>> list(@RequestParam(required = false) String category,
                                           @RequestParam(required = false) Boolean inStock) {
        StringBuilder sql = new StringBuilder("SELECT * FROM PRODUCTS WHERE DISCONTINUED = FALSE");
        if (category != null) sql.append(" AND CATEGORY = '").append(category).append("'");
        if (inStock != null && inStock) sql.append(" AND STOCK_QTY > 0");
        return jdbc.queryForList(sql.toString());
    }

    @GetMapping("/{sku}")
    public Map<String, Object> getBySku(@PathVariable String sku) {
        List<Map<String, Object>> rows = jdbc.queryForList(
            "SELECT * FROM PRODUCTS WHERE SKU = ?", sku);
        if (rows.isEmpty()) throw new RuntimeException("Product not found");
        return rows.get(0);
    }

    @PostMapping
    public Map<String, Object> create(@RequestBody Map<String, Object> body) {
        String sku = (String) body.get("sku");
        String name = (String) body.get("name");
        String category = (String) body.get("category");
        double price = ((Number) body.get("price")).doubleValue();
        int stock = body.containsKey("stockQty") ? ((Number) body.get("stockQty")).intValue() : 0;
        int reorder = body.containsKey("reorderLevel") ? ((Number) body.get("reorderLevel")).intValue() : 10;

        jdbc.update("INSERT INTO PRODUCTS (SKU, NAME, CATEGORY, PRICE, STOCK_QTY, REORDER_LEVEL, DISCONTINUED) " +
            "VALUES (?, ?, ?, ?, ?, ?, FALSE)", sku, name, category, price, stock, reorder);

        Map<String, Object> result = new HashMap<>();
        result.put("sku", sku);
        result.put("status", "created");
        return result;
    }

    @PutMapping("/{sku}/stock")
    public Map<String, Object> updateStock(@PathVariable String sku,
                                            @RequestBody Map<String, Object> body) {
        int adjustment = ((Number) body.get("adjustment")).intValue();
        String reason = (String) body.getOrDefault("reason", "manual adjustment");

        jdbc.update("UPDATE PRODUCTS SET STOCK_QTY = STOCK_QTY + ? WHERE SKU = ?", adjustment, sku);

        // log stock movement
        jdbc.update("INSERT INTO STOCK_MOVEMENTS (PRODUCT_SKU, QUANTITY_CHANGE, REASON, CREATED_AT) " +
            "VALUES (?, ?, ?, NOW())", sku, adjustment, reason);

        List<Map<String, Object>> updated = jdbc.queryForList(
            "SELECT STOCK_QTY FROM PRODUCTS WHERE SKU = ?", sku);

        Map<String, Object> result = new HashMap<>();
        result.put("sku", sku);
        result.put("adjustment", adjustment);
        result.put("newStock", updated.get(0).get("STOCK_QTY"));
        return result;
    }

    // reorder report: products below reorder level
    @GetMapping("/reorder-report")
    public List<Map<String, Object>> reorderReport() {
        return jdbc.queryForList(
            "SELECT SKU, NAME, CATEGORY, STOCK_QTY, REORDER_LEVEL " +
            "FROM PRODUCTS WHERE STOCK_QTY <= REORDER_LEVEL AND DISCONTINUED = FALSE " +
            "ORDER BY (REORDER_LEVEL - STOCK_QTY) DESC");
    }
}
