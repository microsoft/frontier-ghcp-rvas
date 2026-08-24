SET NOCOUNT ON;
SET XACT_ABORT ON;
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (SELECT 1 FROM Sales.Customer)
BEGIN
    ;WITH
    digits AS
    (
        SELECT digit
        FROM (VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9)) AS d (digit)
    ),
    numbers AS
    (
        SELECT
            1 + a.digit + (10 * b.digit) + (100 * c.digit) + (1000 * d.digit) AS n
        FROM digits AS a
        CROSS JOIN digits AS b
        CROSS JOIN digits AS c
        CROSS JOIN digits AS d
    )
    INSERT Sales.Customer (Email, DisplayName, RegionCode, LoyaltyTier, CreatedAt)
    SELECT
        CONCAT(N'customer', RIGHT(CONCAT(N'00000', n), 5), N'@example.invalid'),
        CONCAT(N'Customer ', n),
        CASE n % 5
            WHEN 0 THEN 'US'
            WHEN 1 THEN 'GB'
            WHEN 2 THEN 'DE'
            WHEN 3 THEN 'FR'
            ELSE 'NL'
        END,
        CASE WHEN n <= 50 THEN 4 WHEN n % 10 = 0 THEN 2 ELSE 0 END,
        DATEADD(minute, -n, CONVERT(datetime2(3), '2026-01-01T00:00:00'))
    FROM numbers;
END;
GO

IF NOT EXISTS (SELECT 1 FROM Catalog.Product)
BEGIN
    ;WITH
    digits AS
    (
        SELECT digit
        FROM (VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9)) AS d (digit)
    ),
    numbers AS
    (
        SELECT
            1 + a.digit + (10 * b.digit) + (100 * c.digit) AS n
        FROM digits AS a
        CROSS JOIN digits AS b
        CROSS JOIN digits AS c
        WHERE 1 + a.digit + (10 * b.digit) + (100 * c.digit) <= 200
    )
    INSERT Catalog.Product (Sku, ProductName, CategoryCode, UnitPrice, IsActive)
    SELECT
        CONCAT('SKU-', RIGHT(CONCAT('0000', n), 4)),
        CONCAT(N'Peak load product ', n),
        CASE n % 4
            WHEN 0 THEN 'Compute'
            WHEN 1 THEN 'Storage'
            WHEN 2 THEN 'Network'
            ELSE 'Support'
        END,
        CONVERT(decimal(12, 2), 5.00 + ((n * 137) % 8000) / 10.0),
        CASE WHEN n % 29 = 0 THEN 0 ELSE 1 END
    FROM numbers;
END;
GO

IF NOT EXISTS (SELECT 1 FROM Sales.SalesOrder)
BEGIN
    ;WITH
    digits AS
    (
        SELECT digit
        FROM (VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9)) AS d (digit)
    ),
    numbers AS
    (
        SELECT
            1
            + a.digit
            + (10 * b.digit)
            + (100 * c.digit)
            + (1000 * d.digit)
            + (10000 * e.digit) AS n
        FROM digits AS a
        CROSS JOIN digits AS b
        CROSS JOIN digits AS c
        CROSS JOIN digits AS d
        CROSS JOIN digits AS e
    )
    INSERT Sales.SalesOrder
    (
        CustomerId,
        OrderedAt,
        OrderStatus,
        ChannelCode,
        TotalAmount,
        LastUpdatedAt
    )
    SELECT
        CASE
            WHEN n % 100 < 45 THEN ((n * 17) % 50) + 1
            ELSE ((n * 7919) % 9950) + 51
        END,
        DATEADD(minute, -(n % 129600), CONVERT(datetime2(3), '2026-07-15T12:00:00')),
        CASE n % 20
            WHEN 0 THEN 'Cancelled'
            WHEN 1 THEN 'Pending'
            WHEN 2 THEN 'Packed'
            WHEN 3 THEN 'Paid'
            ELSE 'Shipped'
        END,
        CASE n % 10 WHEN 0 THEN 'Partner' WHEN 1 THEN 'Mobile' ELSE 'Web' END,
        CONVERT(decimal(14, 2), 20.00 + ((n * 97) % 90000) / 10.0),
        DATEADD(second, n % 3600,
            DATEADD(minute, -(n % 129600), CONVERT(datetime2(3), '2026-07-15T12:00:00')))
    FROM numbers;
END;
GO

IF NOT EXISTS (SELECT 1 FROM Sales.SalesOrderLine)
BEGIN
    ;WITH line_numbers AS
    (
        SELECT line_number
        FROM (VALUES (1), (2), (3), (4), (5)) AS lines (line_number)
    )
    INSERT Sales.SalesOrderLine
        (SalesOrderId, LineNumber, ProductId, Quantity, UnitPrice)
    SELECT
        orders.SalesOrderId,
        lines.line_number,
        CASE
            WHEN (orders.SalesOrderId + lines.line_number) % 10 < 6
                THEN ((orders.SalesOrderId + lines.line_number) % 10) + 1
            ELSE ((orders.SalesOrderId * 37 + lines.line_number) % 190) + 11
        END,
        ((orders.SalesOrderId + lines.line_number) % 4) + 1,
        products.UnitPrice
    FROM Sales.SalesOrder AS orders
    CROSS JOIN line_numbers AS lines
    INNER JOIN Catalog.Product AS products
        ON products.ProductId =
            CASE
                WHEN (orders.SalesOrderId + lines.line_number) % 10 < 6
                    THEN ((orders.SalesOrderId + lines.line_number) % 10) + 1
                ELSE ((orders.SalesOrderId * 37 + lines.line_number) % 190) + 11
            END
    WHERE lines.line_number <= 1 + (orders.SalesOrderId % 5);
END;
GO

IF NOT EXISTS (SELECT 1 FROM Sales.PaymentAttempt)
BEGIN
    INSERT Sales.PaymentAttempt
        (SalesOrderId, AttemptedAt, OutcomeCode, ProcessorReference, Amount)
    SELECT
        orders.SalesOrderId,
        DATEADD(second, 20 + (orders.SalesOrderId % 300), orders.OrderedAt),
        CASE orders.SalesOrderId % 25
            WHEN 0 THEN 'Timeout'
            WHEN 1 THEN 'Declined'
            ELSE 'Approved'
        END,
        CONCAT('PAY-', RIGHT(CONCAT('0000000000', orders.SalesOrderId), 10)),
        orders.TotalAmount
    FROM Sales.SalesOrder AS orders;
END;
GO

IF
    (SELECT COUNT_BIG(*) FROM Sales.Customer) <> 10000
    OR (SELECT COUNT_BIG(*) FROM Catalog.Product) <> 200
    OR (SELECT COUNT_BIG(*) FROM Sales.SalesOrder) <> 100000
    OR (SELECT COUNT_BIG(*) FROM Sales.SalesOrderLine) <> 300000
    OR (SELECT COUNT_BIG(*) FROM Sales.PaymentAttempt) <> 100000
BEGIN
    THROW 51000, 'Seed validation failed. Reset the local database and rerun.', 1;
END;
GO
