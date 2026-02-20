/* 
=============================================================
DDL Script: Create Bronze Tables
=============================================================

ddl_bronze.sql

Script Purpose:
This script creates the tables in the 'bronze' schema. It defines tables in a structure closely aligned with the original source 
according to the 'AdventureWorks Database Dictionary'.The tables include primary keys and proper data types to maintain basic data integrity 
while remaining raw and untransformed.

WARNING:
Running this script will **drop existing Bronze tables** if they already exist in the database. 
All existing data in these tables will be permanently lost. Ensure you have backups or are operating in a safe test environment.
*/

-- Drop (if already exists) and (re)create table from source_person

IF OBJECT_ID('bronze.person_person', 'U') IS NOT NULL
    DROP TABLE bronze.person_person;
GO

CREATE TABLE bronze.person_person (
    BusinessEntityID INT NOT NULL,
    PersonType NCHAR(2) NOT NULL,
    NameStyle BIT NOT NULL,
    Title NVARCHAR(8) NULL,
    FirstName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NULL,
    LastName NVARCHAR(50) NOT NULL,
    Suffix NVARCHAR(10) NULL,
    EmailPromotion INT NOT NULL,
    AdditionalContactInfo NVARCHAR(MAX) NULL, -- Changed original XML datatype to NVARCHAR(MAX) due to CSV import characteristics
    Demographics NVARCHAR(MAX) NULL,
    rowguid UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    CONSTRAINT pk_person_person PRIMARY KEY (BusinessEntityID)
);
GO

-- Drop (if already exists) and (re)create individual tables from source_production

IF OBJECT_ID('bronze.production_product', 'U') IS NOT NULL
    DROP TABLE bronze.production_product;
GO

CREATE TABLE bronze.production_product (
    ProductID INT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    ProductNumber NVARCHAR(25) NOT NULL,
    MakeFlag BIT NOT NULL,
    FinishedGoodsFlag BIT NOT NULL,
    Color NVARCHAR(15) NULL,
    SafetyStockLevel SMALLINT NOT NULL,
    ReorderPoint SMALLINT NOT NULL,
    StandardCost MONEY NOT NULL,
    ListPrice MONEY NOT NULL,
    Size NVARCHAR (5) NULL,
    SizeUnitMeasureCode NCHAR(5) NULL,
    WeightUnitMeasureCode NCHAR (3) NULL,
    Weight DECIMAL(8,2) NULL,
    DaysToManufacture INT NOT NULL,
    ProductLine NCHAR(2) NULL,
    Class NCHAR(2) NULL,
    Style NCHAR(2) NULL,
    ProductSubcategoryID INT NULL,
    ProductModelID INT NULL,
    SellStartDate DATETIME NOT NULL,
    SellEndDate DATETIME NULL,
    DiscontinuedDate DATETIME NULL,
    rowguid UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    CONSTRAINT pk_production_product PRIMARY KEY (ProductID)
);
GO

IF OBJECT_ID('bronze.production_productcategory', 'U') IS NOT NULL
    DROP TABLE bronze.production_productcategory;
GO

CREATE TABLE bronze.production_productcategory (
    ProductCategoryID INT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    rowguid UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    CONSTRAINT pk_production_productcategory PRIMARY KEY (ProductCategoryID)
);
GO

IF OBJECT_ID('bronze.production_productsubcategory', 'U') IS NOT NULL
    DROP TABLE bronze.production_productsubcategory;
GO

CREATE TABLE bronze.production_productsubcategory (
    ProductSubcategoryID INT NOT NULL,
    ProductCategoryID INT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    rowguid UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    CONSTRAINT pk_production_productsubcategory PRIMARY KEY (ProductSubcategoryID)
);
GO

-- Drop (if already exists) and (re)create individual tables from source_sales

IF OBJECT_ID('bronze.sales_customer', 'U') IS NOT NULL
    DROP TABLE bronze.sales_customer;
GO

CREATE TABLE bronze.sales_customer (
    CustomerID INT NOT NULL,
    PersonID INT NULL,
    StoreID INT NULL,
    TerritoryID INT NULL,
    AccountNumber VARCHAR(10) NOT NULL,
    rowguid UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    CONSTRAINT pk_sales_customer PRIMARY KEY (CustomerID)
);
GO

IF OBJECT_ID('bronze.sales_salesorderdetail', 'U') IS NOT NULL
    DROP TABLE bronze.sales_salesorderdetail;
GO

CREATE TABLE bronze.sales_salesorderdetail (
    SalesOrderID INT NOT NULL,
    SalesOrderDetailID INT NOT NULL,
    CarrierTrackingNumber NVARCHAR(25) NULL,
    OrderQty SMALLINT NOT NULL,
    ProductID INT NOT NULL,
    SpecialOfferID INT NOT NULL,
    UnitPrice MONEY NOT NULL,
    UnitPriceDiscount MONEY NOT NULL,
    LineTotal NUMERIC(38,6) NOT NULL,
    rowguid UNIQUEIDENTIFIER NOT NULL, 
    ModifiedDate DATETIME NOT NULL,
    CONSTRAINT pk_sales_salesorderdetail PRIMARY KEY (SalesOrderID, SalesOrderDetailID) -- Note: Two columns as primary key
);
GO

IF OBJECT_ID('bronze.sales_salesorderheader', 'U') IS NOT NULL
    DROP TABLE bronze.sales_salesorderheader;
GO

CREATE TABLE bronze.sales_salesorderheader (
    SalesOrderID INT NOT NULL,
    RevisionNumber TINYINT NOT NULL,
    OrderDate DATETIME NOT NULL,
    DueDate DATETIME NOT NULL,
    ShipDate DATETIME NULL,
    Status TINYINT NOT NULL,
    OnlineOrderFlag BIT NOT NULL,
    SalesOrderNumber NVARCHAR(25) NOT NULL,
    PurchaseOrderNumber NVARCHAR(25) NULL,
    AccountNumber NVARCHAR(15) NULL,
    CustomerID INT NOT NULL,
    SalesPersonID INT NULL,
    TerritoryID INT NULL,
    BillToAddressID INT NOT NULL,
    ShipToAddressID INT NOT NULL,
    ShipMethodID INT NOT NULL,
    CreditCardID INT NULL,
    CreditCardApprovalCode VARCHAR(15) NULL,
    CurrencyRateID INT NULL,
    SubTotal MONEY NOT NULL,
    TaxAmt MONEY NOT NULL,
    Freight MONEY NOT NULL,
    TotalDue MONEY NOT NULL,
    Comment NVARCHAR(128) NULL,
    rowguid UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    CONSTRAINT pk_sales_salesorderheader PRIMARY KEY (SalesOrderID)
);
GO

IF OBJECT_ID('bronze.sales_salesterritory', 'U') IS NOT NULL
    DROP TABLE bronze.sales_salesterritory;
GO

CREATE TABLE bronze.sales_salesterritory (
    TerritoryID INT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    CountryRegionCode NVARCHAR(3) NOT NULL,
    [Group] NVARCHAR(50) NOT NULL,  -- Renamed column name from 'Group' to '[Group]' due to error with SQL 'Group' syntax
    SalesYTD MONEY NOT NULL,
    SalesLastYear MONEY NOT NULL,
    CostYTD MONEY NOT NULL,
    CostLastYear MONEY NOT NULL,
    rowguid	UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    CONSTRAINT pk_sales_salesterritory PRIMARY KEY (TerritoryID)
);
GO