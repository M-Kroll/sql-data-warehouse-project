/* 
=============================================================
DDL Script: Create Bronze Tables
=============================================================

ddl_bronze.sql

Purpose:
Creates tables in the 'bronze' schema to store raw source data.

The Bronze layer prioritizes reliable ingestion of CSV data.
Columns are intentionally defined with flexible NVARCHAR types 
and permissive NULL settings to avoid load failures caused by 
format inconsistencies or non-standard NULL values.

Strict data typing, validation, and transformations are deferred 
to downstream layers (e.g., Silver layer).

WARNING:
Running this script will drop existing Bronze tables.
All data in those tables will be permanently lost.
*/

-- Drop (if already exists) and (re)create table from source_person

IF OBJECT_ID('bronze.person_person', 'U') IS NOT NULL
    DROP TABLE bronze.person_person;
GO

CREATE TABLE bronze.person_person (
    BusinessEntityID NVARCHAR(20) NULL,
    PersonType NVARCHAR(10) NULL,
    NameStyle NVARCHAR(5) NULL,
    Title NVARCHAR(50) NULL,
    FirstName NVARCHAR(100) NULL,
    MiddleName NVARCHAR(100) NULL,
    LastName NVARCHAR(100) NULL,
    Suffix NVARCHAR(20) NULL,
    EmailPromotion NVARCHAR(10) NULL,
    AdditionalContactInfo NVARCHAR(MAX) NULL, -- Changed to NVARCHAR(MAX) due to original XML datatype
    Demographics NVARCHAR(MAX) NULL,
    rowguid NVARCHAR(50) NULL,
    ModifiedDate NVARCHAR(50) NULL
);
GO

-- Drop (if already exists) and (re)create individual tables from source_production

IF OBJECT_ID('bronze.production_product', 'U') IS NOT NULL
    DROP TABLE bronze.production_product;
GO

CREATE TABLE bronze.production_product (
    ProductID NVARCHAR(20) NULL,
    Name NVARCHAR(100) NULL,
    ProductNumber NVARCHAR(50) NULL,
    MakeFlag NVARCHAR(5) NULL,
    FinishedGoodsFlag NVARCHAR(5) NULL,
    Color NVARCHAR(30) NULL,
    SafetyStockLevel NVARCHAR(20) NULL,
    ReorderPoint NVARCHAR(20) NULL,
    StandardCost NVARCHAR(50) NULL,
    ListPrice NVARCHAR(50) NULL,
    Size NVARCHAR (10) NULL,
    SizeUnitMeasureCode NVARCHAR(10) NULL,
    WeightUnitMeasureCode NVARCHAR (10) NULL,
    Weight NVARCHAR(50) NULL,
    DaysToManufacture NVARCHAR(50) NULL,
    ProductLine NVARCHAR(10) NULL,
    Class NVARCHAR(10) NULL,
    Style NVARCHAR(10) NULL,
    ProductSubcategoryID NVARCHAR(20) NULL,
    ProductModelID NVARCHAR(20) NULL,
    SellStartDate NVARCHAR(50) NULL,
    SellEndDate NVARCHAR(50) NULL,
    DiscontinuedDate NVARCHAR(50) NULL,
    rowguid NVARCHAR(50) NULL,
    ModifiedDate NVARCHAR(50) NULL
);
GO

IF OBJECT_ID('bronze.production_productcategory', 'U') IS NOT NULL
    DROP TABLE bronze.production_productcategory;
GO

CREATE TABLE bronze.production_productcategory (
    ProductCategoryID NVARCHAR(50) NULL,
    Name NVARCHAR(100) NULL,
    rowguid NVARCHAR(50) NULL,
    ModifiedDate NVARCHAR(100) NULL
);
GO

IF OBJECT_ID('bronze.production_productsubcategory', 'U') IS NOT NULL
    DROP TABLE bronze.production_productsubcategory;
GO

CREATE TABLE bronze.production_productsubcategory (
    ProductSubcategoryID NVARCHAR(50) NULL,
    ProductCategoryID NVARCHAR(50) NULL,
    Name NVARCHAR(100) NULL,
    rowguid NVARCHAR(50) NULL,
    ModifiedDate NVARCHAR(50) NULL
);
GO

-- Drop (if already exists) and (re)create individual tables from source_sales

IF OBJECT_ID('bronze.sales_customer', 'U') IS NOT NULL
    DROP TABLE bronze.sales_customer;
GO

CREATE TABLE bronze.sales_customer (
    CustomerID NVARCHAR(20) NULL,
    PersonID NVARCHAR(20) NULL,
    StoreID NVARCHAR(20) NULL,
    TerritoryID NVARCHAR(20) NULL,
    AccountNumber VARCHAR(20) NULL,
    rowguid NVARCHAR(50) NULL,
    ModifiedDate NVARCHAR(50) NULL
);
GO

IF OBJECT_ID('bronze.sales_salesorderdetail', 'U') IS NOT NULL
    DROP TABLE bronze.sales_salesorderdetail;
GO

CREATE TABLE bronze.sales_salesorderdetail (
    SalesOrderID NVARCHAR(20) NULL,
    SalesOrderDetailID NVARCHAR(20) NULL,
    CarrierTrackingNumber NVARCHAR(50) NULL,
    OrderQty NVARCHAR(20) NULL,
    ProductID NVARCHAR(20) NULL,
    SpecialOfferID NVARCHAR(20) NOT NULL,
    UnitPrice NVARCHAR(50) NULL,
    UnitPriceDiscount NVARCHAR(50) NULL,
    LineTotal NVARCHAR(100) NULL,
    rowguid NVARCHAR(50) NULL, 
    ModifiedDate NVARCHAR(50) NULL
);
GO

IF OBJECT_ID('bronze.sales_salesorderheader', 'U') IS NOT NULL
    DROP TABLE bronze.sales_salesorderheader;
GO

CREATE TABLE bronze.sales_salesorderheader (
    SalesOrderID NVARCHAR(20) NULL,
    RevisionNumber NVARCHAR(20) NULL,
    OrderDate NVARCHAR(50) NULL,
    DueDate NVARCHAR(50) NULL,
    ShipDate NVARCHAR(50) NULL,
    Status NVARCHAR(20) NULL,
    OnlineOrderFlag NVARCHAR(5) NULL,
    SalesOrderNumber NVARCHAR(50) NULL,
    PurchaseOrderNumber NVARCHAR(50) NULL,
    AccountNumber NVARCHAR(50) NULL,
    CustomerID NVARCHAR(20) NULL,
    SalesPersonID NVARCHAR(20) NULL,
    TerritoryID NVARCHAR(20) NULL,
    BillToAddressID NVARCHAR(20) NULL,
    ShipToAddressID NVARCHAR(20) NULL,
    ShipMethodID NVARCHAR(20) NULL,
    CreditCardID NVARCHAR(20) NULL,
    CreditCardApprovalCode NVARCHAR(50) NULL,
    CurrencyRateID NVARCHAR(20) NULL,
    SubTotal NVARCHAR(50)NULL,
    TaxAmt NVARCHAR(50) NULL,
    Freight NVARCHAR(50) NULL,
    TotalDue NVARCHAR(20) NULL,
    Comment NVARCHAR(200) NULL,
    rowguid NVARCHAR(50) NULL,
    ModifiedDate NVARCHAR(50) NULL
);
GO

IF OBJECT_ID('bronze.sales_salesterritory', 'U') IS NOT NULL
    DROP TABLE bronze.sales_salesterritory;
GO

CREATE TABLE bronze.sales_salesterritory (
    TerritoryID NVARCHAR(20) NULL,
    Name NVARCHAR(100) NULL,
    CountryRegionCode NVARCHAR(10) NULL,
    [Group] NVARCHAR(100) NULL,  -- Renamed column name from 'Group' to '[Group]' due to error with SQL 'Group' syntax
    SalesYTD NVARCHAR(50) NULL,
    SalesLastYear NVARCHAR(50) NULL,
    CostYTD NVARCHAR(50) NULL,
    CostLastYear NVARCHAR(50) NULL,
    rowguid	NVARCHAR(50) NULL,
    ModifiedDate NVARCHAR(50) NULL
);
GO