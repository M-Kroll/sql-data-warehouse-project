/* 
=============================================================
Stored Procedure: Load Silver Layer
=============================================================

proc_load_silver.sql

Purpose:
This script performs an ETL process: data from the bronze layer is cleansed
and loaded into the silver layer. The silver layer serves as a reliable, cleaned staging 
area for downstream analytics. Actions performed include truncating Silver tables 
and inserting transformed and cleansed data from Bronze into Silver tables.

Parameters:
None. This stored procedure does not accept parameters and does not return values.

Usage Example:
EXEC silver.load_silver;

WARNING:
Running this procedure will overwrite existing data in the silver tables.
Ensure that previous versions are backed up if needed.
*/

TRUNCATE TABLE silver.person_person;
INSERT INTO silver.person_person (
    BusinessEntityID,
    PersonType,
    NameStyle,
    Title,
    FirstName,
    MiddleName,
    LastName,
    Suffix,
    EmailPromotion,
    AdditionalContactInfo,
    Demographics,
    rowguid,
    ModifiedDate
)
SELECT
    TRY_CAST(BusinessEntityID AS INT) AS BusinessEntityID,
    TRY_CAST(
        CASE 
            WHEN LTRIM(RTRIM(PersonType)) IN ('IN','EM','SP','SC','VC','GC') 
            THEN LTRIM(RTRIM(PersonType))
            ELSE '??'  -- Invalid value, if not in correct format
        END AS NCHAR(2)) AS PersonType, 
    TRY_CAST(NameStyle AS BIT) AS NameStyle,
    LEFT(
        CASE 
            WHEN Title IS NULL THEN NULL
            WHEN LTRIM(RTRIM(Title)) IN ('Mr', 'Mr.') THEN 'Mr.'
            WHEN LTRIM(RTRIM(Title)) IN ('Ms', 'Ms.') THEN 'Ms.'
            WHEN LTRIM(RTRIM(Title)) IN ('Mrs', 'Mrs.') THEN 'Mrs.'
            WHEN LTRIM(RTRIM(Title)) IN ('Sr', 'Sr.') THEN 'Sr.'
            WHEN LTRIM(RTRIM(Title)) IN ('Sra', 'Sra.') THEN 'Sra.'
            WHEN LTRIM(RTRIM(Title)) IN ('Dr', 'Dr.') THEN 'Dr.'
            ELSE LTRIM(RTRIM(Title))
        END
    , 8) AS Title,
    LEFT(LTRIM(RTRIM(FirstName)), 50) AS FirstName,
    LEFT(LTRIM(RTRIM(MiddleName)), 50) AS MiddleName,
    LEFT(LTRIM(RTRIM(LastName)), 50) AS LastName,
    LEFT(LTRIM(RTRIM(Suffix)), 10) AS Suffix,
    CASE 
        WHEN EmailPromotion IN (0,1,2) THEN EmailPromotion
        ELSE 0  -- Default: No e-mail promotions
    END AS EmailPromotion,
    AdditionalContactInfo,
    Demographics,
    TRY_CAST(rowguid AS UNIQUEIDENTIFIER) AS rowguid,
    TRY_CONVERT(DATETIME, ModifiedDate, 120) AS ModifiedDate
FROM bronze.person_person
WHERE BusinessEntityID IS NOT NULL
    AND FirstName IS NOT NULL
    AND LastName IS NOT NULL
    AND LTRIM(RTRIM(FirstName)) <> ''
    AND LTRIM(RTRIM(LastName)) <> ''
    AND TRY_CONVERT(DATETIME, ModifiedDate, 120) <= GETDATE();  -- No future date values