/* 
=============================================================
Create Database and Schemas
=============================================================

init_database.sql

Script Purpose:
This script initializes the SQL Server database for the project by creating a fresh database 
and the required schemas for the Medallion architecture (bronze, silver, gold). 
It sets up a clean environment for ingesting raw data and building the data warehouse layers.

WARNING:
Executing this script will permanently delete the existing 'M_Kroll_DWH' database
if it exists, including all data, tables, and objects contained within. 
Ensure that any important data is backed up before running this script.
*/

USE master;
GO

-- Drop and recreate the 'M_Kroll_DWH' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'M_Kroll_DWH')
BEGIN
    ALTER DATABASE M_Kroll_DWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE M_Kroll_DWH;
END;
GO

-- Create the 'M_Kroll_DWH' database
CREATE DATABASE M_Kroll_DWH;
GO

USE M_Kroll_DWH;
GO

-- Create Medallion Architecture schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
