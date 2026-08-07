SET NOCOUNT ON;
SET XACT_ABORT ON;
SET QUOTED_IDENTIFIER ON;
GO

IF SCHEMA_ID(N'Catalog') IS NULL
    EXEC(N'CREATE SCHEMA Catalog AUTHORIZATION dbo;');
GO

IF SCHEMA_ID(N'Sales') IS NULL
    EXEC(N'CREATE SCHEMA Sales AUTHORIZATION dbo;');
GO

IF OBJECT_ID(N'Sales.Customer', N'U') IS NULL
BEGIN
    CREATE TABLE Sales.Customer
    (
        CustomerId bigint IDENTITY(1, 1) NOT NULL,
        Email nvarchar(320) NOT NULL,
        DisplayName nvarchar(160) NOT NULL,
        RegionCode char(2) NOT NULL,
        LoyaltyTier tinyint NOT NULL
            CONSTRAINT DF_Customer_LoyaltyTier DEFAULT (0),
        CreatedAt datetime2(3) NOT NULL
            CONSTRAINT DF_Customer_CreatedAt DEFAULT (SYSUTCDATETIME()),
        RowVersion rowversion NOT NULL,
        CONSTRAINT PK_Customer PRIMARY KEY CLUSTERED (CustomerId),
        CONSTRAINT UQ_Customer_Email UNIQUE NONCLUSTERED (Email),
        CONSTRAINT CK_Customer_LoyaltyTier CHECK (LoyaltyTier BETWEEN 0 AND 4)
    );
END;
GO

IF OBJECT_ID(N'Catalog.Product', N'U') IS NULL
BEGIN
    CREATE TABLE Catalog.Product
    (
        ProductId int IDENTITY(1, 1) NOT NULL,
        Sku varchar(24) NOT NULL,
        ProductName nvarchar(180) NOT NULL,
        CategoryCode varchar(20) NOT NULL,
        UnitPrice decimal(12, 2) NOT NULL,
        IsActive bit NOT NULL
            CONSTRAINT DF_Product_IsActive DEFAULT (1),
        CONSTRAINT PK_Product PRIMARY KEY CLUSTERED (ProductId),
        CONSTRAINT UQ_Product_Sku UNIQUE NONCLUSTERED (Sku),
        CONSTRAINT CK_Product_UnitPrice CHECK (UnitPrice > 0)
    );
END;
GO

IF OBJECT_ID(N'Sales.SalesOrder', N'U') IS NULL
BEGIN
    CREATE TABLE Sales.SalesOrder
    (
        SalesOrderId bigint IDENTITY(1, 1) NOT NULL,
        CustomerId bigint NOT NULL,
        OrderedAt datetime2(3) NOT NULL,
        OrderStatus varchar(20) NOT NULL,
        ChannelCode varchar(12) NOT NULL,
        TotalAmount decimal(14, 2) NOT NULL,
        LastUpdatedAt datetime2(3) NOT NULL,
        RowVersion rowversion NOT NULL,
        CONSTRAINT PK_SalesOrder PRIMARY KEY CLUSTERED (SalesOrderId),
        CONSTRAINT FK_SalesOrder_Customer FOREIGN KEY (CustomerId)
            REFERENCES Sales.Customer (CustomerId),
        CONSTRAINT CK_SalesOrder_Status CHECK
            (OrderStatus IN ('Pending', 'Paid', 'Packed', 'Shipped', 'Cancelled')),
        CONSTRAINT CK_SalesOrder_Channel CHECK
            (ChannelCode IN ('Web', 'Mobile', 'Partner')),
        CONSTRAINT CK_SalesOrder_Total CHECK (TotalAmount >= 0)
    );
END;
GO

IF OBJECT_ID(N'Sales.SalesOrderLine', N'U') IS NULL
BEGIN
    CREATE TABLE Sales.SalesOrderLine
    (
        SalesOrderId bigint NOT NULL,
        LineNumber smallint NOT NULL,
        ProductId int NOT NULL,
        Quantity smallint NOT NULL,
        UnitPrice decimal(12, 2) NOT NULL,
        LineAmount AS (CONVERT(decimal(14, 2), Quantity * UnitPrice)) PERSISTED,
        CONSTRAINT PK_SalesOrderLine PRIMARY KEY CLUSTERED
            (SalesOrderId, LineNumber),
        CONSTRAINT FK_SalesOrderLine_Order FOREIGN KEY (SalesOrderId)
            REFERENCES Sales.SalesOrder (SalesOrderId),
        CONSTRAINT FK_SalesOrderLine_Product FOREIGN KEY (ProductId)
            REFERENCES Catalog.Product (ProductId),
        CONSTRAINT CK_SalesOrderLine_Quantity CHECK (Quantity BETWEEN 1 AND 20),
        CONSTRAINT CK_SalesOrderLine_UnitPrice CHECK (UnitPrice > 0)
    );
END;
GO

IF OBJECT_ID(N'Sales.PaymentAttempt', N'U') IS NULL
BEGIN
    CREATE TABLE Sales.PaymentAttempt
    (
        PaymentAttemptId bigint IDENTITY(1, 1) NOT NULL,
        SalesOrderId bigint NOT NULL,
        AttemptedAt datetime2(3) NOT NULL,
        OutcomeCode varchar(16) NOT NULL,
        ProcessorReference varchar(40) NULL,
        Amount decimal(14, 2) NOT NULL,
        CONSTRAINT PK_PaymentAttempt PRIMARY KEY CLUSTERED (PaymentAttemptId),
        CONSTRAINT FK_PaymentAttempt_Order FOREIGN KEY (SalesOrderId)
            REFERENCES Sales.SalesOrder (SalesOrderId),
        CONSTRAINT CK_PaymentAttempt_Outcome CHECK
            (OutcomeCode IN ('Approved', 'Declined', 'Timeout')),
        CONSTRAINT CK_PaymentAttempt_Amount CHECK (Amount >= 0)
    );
END;
GO
