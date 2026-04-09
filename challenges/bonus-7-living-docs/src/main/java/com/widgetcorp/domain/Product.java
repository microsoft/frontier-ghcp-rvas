package com.widgetcorp.domain;

/**
 * Represents inventory item
 * @author T. Miller
 * @since 1.0
 */
public class Product {

    private Long id;
    private String sku;
    private String name;
    private String description;
    private String category;
    private double price;
    private int stockQty;
    private int reorderLevel;
    private String warehouseCode;
    private boolean discontinued;

    public Product() {}

    public Product(String sku, String name, String category, double price) {
        this.sku = sku;
        this.name = name;
        this.category = category;
        this.price = price;
        this.stockQty = 0;
        this.reorderLevel = 10;
        this.discontinued = false;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getStockQty() { return stockQty; }
    public void setStockQty(int stockQty) { this.stockQty = stockQty; }
    public int getReorderLevel() { return reorderLevel; }
    public void setReorderLevel(int reorderLevel) { this.reorderLevel = reorderLevel; }
    public String getWarehouseCode() { return warehouseCode; }
    public void setWarehouseCode(String warehouseCode) { this.warehouseCode = warehouseCode; }
    public boolean isDiscontinued() { return discontinued; }
    public void setDiscontinued(boolean discontinued) { this.discontinued = discontinued; }
}
