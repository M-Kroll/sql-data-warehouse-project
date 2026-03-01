/* 
=============================================================
Stored Procedure: Load Bronze Layer
=============================================================

proc_load_bronze.sql

Purpose:
This stored procedure loads raw CSV data from source files into the Bronze schema tables.
All target tables are truncated before loading to ensure a full reload.
The stored procedure performs no transformations, validations, or data type
conversions. It is designed strictly for raw data ingestion.

Parameters:
None. This stored procedure does not accept parameters and does not return values.

Usage Example:
EXEC bronze.load_bronze;

WARNING:
This stored procedure performs a full refresh by truncating all Bronze tables
before loading. All existing data in the Bronze layer will be permanently
deleted. No validation is applied during loading. Invalid, duplicate,
or inconsistent data will be inserted as-is and must be handled in
downstream layers (e.g., Silver layer).
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	PRINT '==================================================';
	PRINT 'Loading Bronze Layer';
	PRINT '==================================================';
	
	PRINT '--------------------------------------------------';
	PRINT 'Loading tables from source_person origin folder';
	PRINT '--------------------------------------------------';

	PRINT '>> Truncating table: bronze.person_person';
	TRUNCATE TABLE bronze.person_person;

	PRINT '>> Inserting data into: bronze.person_person';
	BULK INSERT bronze.person_person
	FROM 'C:\sql\sql-data-warehouse-project\datasets\source_person\person.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);

	PRINT '--------------------------------------------------';
	PRINT 'Loading tables from source_production origin folder';
	PRINT '--------------------------------------------------';

	PRINT '>> Truncating table: bronze.production_product';
	TRUNCATE TABLE bronze.production_product;

	PRINT '>> Inserting data into: bronze.production_product';
	BULK INSERT bronze.production_product
	FROM 'C:\sql\sql-data-warehouse-project\datasets\source_production\product.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);

	PRINT '>> Truncating table: bronze.production_productcategory';
	TRUNCATE TABLE bronze.production_productcategory;

	PRINT '>> Inserting data into: bronze.production_productcategory';
	BULK INSERT bronze.production_productcategory
	FROM 'C:\sql\sql-data-warehouse-project\datasets\source_production\productcategory.csv' 
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);

	PRINT '>> Truncating table: bronze.production_productsubcategory';
	TRUNCATE TABLE bronze.production_productsubcategory;

	PRINT '>> Inserting data into: bronze.production_productsubcategory';
	BULK INSERT bronze.production_productsubcategory
	FROM 'C:\sql\sql-data-warehouse-project\datasets\source_production\productsubcategory.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);

	PRINT '--------------------------------------------------';
	PRINT 'Loading tables from source_sales origin folder';
	PRINT '--------------------------------------------------';

	PRINT '>> Truncating table: bronze.sales_customer';
	TRUNCATE TABLE bronze.sales_customer;
	
	PRINT '>> Inserting data into: bronze.sales_customer';
	BULK INSERT bronze.sales_customer
	FROM 'C:\sql\sql-data-warehouse-project\datasets\source_sales\customer.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);

	PRINT '>> Truncating table: bronze.sales_salesorderdetail';
	TRUNCATE TABLE bronze.sales_salesorderdetail;

	PRINT '>> Inserting data into: bronze.sales_salesorderdetail';
	BULK INSERT bronze.sales_salesorderdetail
	FROM 'C:\sql\sql-data-warehouse-project\datasets\source_sales\salesorderdetail.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);

	PRINT '>> Truncating table: bronze.sales_salesorderheader';
	TRUNCATE TABLE bronze.sales_salesorderheader;

	PRINT '>> Inserting data into: bronze.sales_salesorderheader';
	BULK INSERT bronze.sales_salesorderheader
	FROM 'C:\sql\sql-data-warehouse-project\datasets\source_sales\salesorderheader.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);

	PRINT '>> Truncating table: bronze.sales_salesterritory';
	TRUNCATE TABLE bronze.sales_salesterritory;

	PRINT '>> Inserting data into: bronze.sales_salesterritory';
	BULK INSERT bronze.sales_salesterritory
	FROM 'C:\sql\sql-data-warehouse-project\datasets\source_sales\salesterritory.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);
END