SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
GO

-- Query ID: Q1
-- Recent orders for customers matching an operations search.
DECLARE @Q1FromDate date = '2026-06-15';
DECLARE @Q1EmailFragment nvarchar(100) = N'customer0';

SELECT TOP (200)
    orders.SalesOrderId,
    customers.Email,
    orders.OrderStatus,
    orders.TotalAmount,
    orders.OrderedAt
FROM Sales.SalesOrder AS orders
INNER JOIN Sales.Customer AS customers
    ON customers.CustomerId = orders.CustomerId
WHERE
    CAST(orders.OrderedAt AS date) >= @Q1FromDate
    AND customers.Email LIKE N'%' + @Q1EmailFragment + N'%'
ORDER BY orders.OrderedAt DESC;
GO

-- Query ID: Q2
-- Customer value report used by the peak-load support desk.
DECLARE @Q2FromDate date = '2026-04-01';

SELECT TOP (50)
    customers.CustomerId,
    customers.Email,
    (
        SELECT SUM(orders.TotalAmount)
        FROM Sales.SalesOrder AS orders
        WHERE
            orders.CustomerId = customers.CustomerId
            AND CONVERT(date, orders.OrderedAt) >= @Q2FromDate
            AND orders.OrderStatus <> 'Cancelled'
    ) AS CustomerValue
FROM Sales.Customer AS customers
ORDER BY CustomerValue DESC;
GO

-- Query ID: Q3
-- Product hot list for capacity planning.
DECLARE @Q3ProductTerm nvarchar(100) = N'product';

SELECT TOP (25)
    products.ProductId,
    products.ProductName,
    SUM(lines.Quantity) AS Units,
    SUM(lines.LineAmount) AS Revenue
FROM Sales.SalesOrderLine AS lines
INNER JOIN Catalog.Product AS products
    ON products.ProductId = lines.ProductId
INNER JOIN Sales.SalesOrder AS orders
    ON orders.SalesOrderId = lines.SalesOrderId
WHERE
    LOWER(products.ProductName) LIKE N'%' + LOWER(@Q3ProductTerm) + N'%'
    AND orders.OrderStatus IN ('Paid', 'Packed', 'Shipped')
GROUP BY products.ProductId, products.ProductName
ORDER BY Revenue DESC;
GO

-- Query ID: Q4
-- Flexible order search used during customer incidents.
DECLARE @Q4CustomerId bigint = 17;
DECLARE @Q4Status varchar(20) = NULL;
DECLARE @Q4FromDate datetime2(3) = '2026-06-01T00:00:00';

SELECT TOP (100)
    orders.SalesOrderId,
    orders.CustomerId,
    orders.OrderStatus,
    orders.ChannelCode,
    orders.TotalAmount,
    orders.LastUpdatedAt
FROM Sales.SalesOrder AS orders
WHERE
    (@Q4CustomerId IS NULL OR orders.CustomerId = @Q4CustomerId)
    AND (@Q4Status IS NULL OR orders.OrderStatus = @Q4Status)
    AND orders.LastUpdatedAt >= @Q4FromDate
ORDER BY orders.LastUpdatedAt DESC;
GO
