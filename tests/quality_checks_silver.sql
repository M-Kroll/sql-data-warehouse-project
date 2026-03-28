/*
===============================================================================
Quality Checks
===============================================================================

quality_checks_silver.sql

Purpose:
This script performs various quality checks for data consistency, accuracy, 
and standardization across the silver layer. 

It includes checks for:
- NULL or duplicate primary keys.
- Unwanted spaces in strings.
- Data standardization and consistency.
- Data consistency between related fields.
- Invalid date ranges and orders.


Usage:
Run these checks after loading the data into silver layer.
Analyse and solve any discrepancies that appear during the checks.
*/

-- ====================================================================
-- Checking 'silver.person_person'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results

SELECT 
    BusinessEntityID,
    COUNT(*) 
FROM silver.person_person
GROUP BY BusinessEntityID
HAVING COUNT(*) > 1 OR BusinessEntityID IS NULL;

-- Data Standardization & Consistency

-- Check PersonType
-- Expectation: Following possible strings only: 'IN','EM','SP','SC','VC','GC'  

SELECT DISTINCT PersonType
FROM silver.person_person
WHERE PersonType NOT IN ('IN','EM','SP','SC','VC','GC')
   OR PersonType IS NULL;

-- Check NameStyle
-- Expectation: Only following possible values: 0,1

SELECT DISTINCT NameStyle
FROM silver.person_person
WHERE NameStyle NOT IN (0,1)
    OR NameStyle IS NULL;

-- Check Title
-- Expectation: Only folling possible strings: 'Mr.', 'Ms.', 'Mrs.', 'Sr.', 'Sra.', 'Dr.' and in this correct format

SELECT DISTINCT LTRIM(RTRIM(Title)) AS Title
FROM silver.person_person
WHERE Title IS NOT NULL
  AND LTRIM(RTRIM(Title)) NOT IN ('Mr.', 'Ms.', 'Mrs.', 'Sr.', 'Sra.', 'Dr.');

-- Check FirstName, MiddleName, LastName and Suffix
-- Expectation: FirstName and LastName not NULL and no unnecessary spaces " "

SELECT *
FROM silver.person_person
WHERE FirstName IS NULL
   OR LastName IS NULL
   OR FirstName <> LTRIM(RTRIM(FirstName))
   OR MiddleName <> LTRIM(RTRIM(MiddleName))
   OR LastName <> LTRIM(RTRIM(LastName))
   OR Suffix <> LTRIM(RTRIM(Suffix));

-- Check EmailPromotion
-- Expectation: Only following possible values: 0,1,2

SELECT DISTINCT EmailPromotion
FROM silver.person_person
WHERE EmailPromotion NOT IN (0,1,2)
    OR EmailPromotion IS NULL;

-- Check Additional ContactInfo
-- Expectation: Proper NULL values and no unecessary spaces " "

SELECT *
FROM silver.person_person
WHERE (AdditionalContactInfo IS NOT NULL AND LTRIM(RTRIM(AdditionalContactInfo)) = '')
    OR (Demographics IS NOT NULL AND LTRIM(RTRIM(Demographics)) = '');

-- Check rowguid
-- Expectation: Each rowguid should be non-NULL and a valid UNIQUEIDENTIFIER; 
-- every value must be globally unique to ensure that each record can be reliably identified across systems.

SELECT *
FROM silver.person_person
WHERE TRY_CAST(rowguid AS UNIQUEIDENTIFIER) IS NULL;

-- Check ModifiedDate
-- Expectation: ModifiedDate should be non-NULL and contain valid datetime values. 
-- Should be in following format: YYYY-MM-DD HH:MM:SS

SELECT * 
FROM silver.person_person
WHERE ModifiedDate IS NULL
   OR TRY_CONVERT(DATETIME, ModifiedDate, 120) IS NULL
   OR TRY_CONVERT(DATETIME, ModifiedDate, 120) > GETDATE();

