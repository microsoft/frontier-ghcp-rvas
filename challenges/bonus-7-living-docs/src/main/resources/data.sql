-- seed data for Widget Corp Inventory Manager

INSERT INTO PRODUCTS (SKU, NAME, CATEGORY, PRICE, STOCK_QTY, REORDER_LEVEL) VALUES
('WDG-001', 'Standard Widget', 'Widgets', 12.99, 250, 50),
('WDG-002', 'Premium Widget', 'Widgets', 24.99, 120, 30),
('WDG-003', 'Mini Widget', 'Widgets', 5.49, 500, 100),
('BLT-001', 'M8 Hex Bolt Pack (100)', 'Fasteners', 18.75, 80, 20),
('BLT-002', 'M10 Hex Bolt Pack (50)', 'Fasteners', 22.50, 15, 20),
('GKT-001', 'Rubber Gasket Set', 'Seals', 34.00, 200, 40),
('GKT-002', 'Silicone Gasket Set', 'Seals', 45.00, 8, 10),
('BRG-001', 'Ball Bearing 6205', 'Bearings', 7.25, 350, 75),
('BRG-002', 'Ball Bearing 6208', 'Bearings', 11.50, 180, 50),
('SPR-001', 'Compression Spring Kit', 'Springs', 28.99, 60, 25);

INSERT INTO ORDERS (ORDER_NUMBER, CUSTOMER_ID, STATUS, SUBTOTAL, TAX_AMOUNT, SHIPPING_COST, TOTAL_AMOUNT, SHIPPING_ADDRESS, BILLING_ADDRESS) VALUES
('ORD-1001', 1, 'DELIVERED', 259.80, 59.75, 0, 319.55, '42 Industrial Park, Zone B', '42 Industrial Park, Zone B'),
('ORD-1002', 2, 'SHIPPED', 112.50, 25.88, 12.50, 150.88, '18 Commerce Drive', '18 Commerce Drive'),
('ORD-1003', 1, 'PENDING', 45.00, 10.35, 12.50, 67.85, '42 Industrial Park, Zone B', '42 Industrial Park, Zone B');

INSERT INTO ORDER_LINES (ORDER_ID, PRODUCT_SKU, PRODUCT_NAME, QUANTITY, UNIT_PRICE, LINE_TOTAL, DISCOUNT_PERCENT) VALUES
(1, 'WDG-001', 'Standard Widget', 20, 12.99, 259.80, 0),
(2, 'BLT-002', 'M10 Hex Bolt Pack (50)', 5, 22.50, 112.50, 0),
(3, 'GKT-002', 'Silicone Gasket Set', 1, 45.00, 45.00, 0);

INSERT INTO STOCK_MOVEMENTS (PRODUCT_SKU, QUANTITY_CHANGE, REASON) VALUES
('WDG-001', -20, 'Order ORD-1001'),
('BLT-002', -5, 'Order ORD-1002'),
('GKT-002', -1, 'Order ORD-1003'),
('WDG-003', 200, 'Restock from supplier'),
('BRG-001', 100, 'Restock from supplier');
