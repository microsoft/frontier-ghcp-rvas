package com.widgetcorp.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/inventory")
public class InventoryController {

    @Autowired
    private JdbcTemplate jdbc;

    @GetMapping("/valuation")
    public Map<String, Object> getValuation() {
        List<Map<String, Object>> rows = jdbc.queryForList(
            "SELECT CATEGORY, SUM(STOCK_QTY * PRICE) as VALUE, SUM(STOCK_QTY) as TOTAL_UNITS " +
            "FROM PRODUCTS WHERE DISCONTINUED = FALSE GROUP BY CATEGORY");

        double totalValue = 0;
        int totalUnits = 0;
        for (Map<String, Object> r : rows) {
            totalValue += ((Number) r.get("VALUE")).doubleValue();
            totalUnits += ((Number) r.get("TOTAL_UNITS")).intValue();
        }

        Map<String, Object> result = new HashMap<>();
        result.put("categories", rows);
        result.put("totalValue", totalValue);
        result.put("totalUnits", totalUnits);
        return result;
    }

    @GetMapping("/movements")
    public List<Map<String, Object>> getMovements(@RequestParam(required = false) String sku,
                                                    @RequestParam(required = false, defaultValue = "50") int limit) {
        StringBuilder sql = new StringBuilder("SELECT * FROM STOCK_MOVEMENTS");
        if (sku != null) sql.append(" WHERE PRODUCT_SKU = '").append(sku).append("'");
        sql.append(" ORDER BY CREATED_AT DESC LIMIT ").append(limit);
        return jdbc.queryForList(sql.toString());
    }

    // warehouse transfer -- moves stock between warehouse codes
    // Added in v2.3 but warehouse codes were never fully implemented
    // Only the default warehouse (WH-01) exists in practice
    @PostMapping("/warehouse-transfer")
    public Map<String, Object> warehouseTransfer(@RequestBody Map<String, Object> body) {
        String sku = (String) body.get("sku");
        String fromWarehouse = (String) body.get("from");
        String toWarehouse = (String) body.get("to");
        int qty = ((Number) body.get("quantity")).intValue();

        // This doesn't actually track warehouse-level inventory.
        // It just logs the movement and pretends it worked.
        // Real implementation was never finished.
        jdbc.update("INSERT INTO STOCK_MOVEMENTS (PRODUCT_SKU, QUANTITY_CHANGE, REASON, CREATED_AT) " +
            "VALUES (?, 0, ?, NOW())",
            sku, "Warehouse transfer: " + fromWarehouse + " -> " + toWarehouse + " qty=" + qty);

        Map<String, Object> result = new HashMap<>();
        result.put("status", "transferred");
        result.put("sku", sku);
        result.put("quantity", qty);
        return result;
    }
}
