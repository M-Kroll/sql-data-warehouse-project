# SQL Data Warehouse Project

## Description

This project implements a structured, SQL Server–based data warehouse and analytics solution using the Microsoft AdventureWorks sample database as a realistic business data source.

The goal is to demonstrate end-to-end data engineering workflows including staging raw source data, applying cleansing and transformation logic, and building a star schema optimized for reporting and KPI-based analytics. The project follows a layered warehouse architecture inspired by the Medallion approach (Bronze, Silver, Gold).

---

## Objectives

- Build a structured Data Warehouse using SQL Server Express
- Ingest raw data into a reproducible staging layer (Bronze)
- Clean and standardize data into a curated integration layer (Silver)
- Model business-ready dimensional data into a star schema (Gold)
- Implement SQL-based KPI queries for business reporting and analysis
- Provide clear documentation and maintainable SQL scripts following naming conventions

---

## Project Structure

```
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project 
│
├── docs/                               # Documentation, architecture and modeling
│   ├── data_architecture.drawio        # Bronze/Silver/Gold architecture diagram
│   ├── data_flow.drawio                # ETL and data flow documentation
│   ├── data_models.drawio              # Star schema / dimensional model
│   ├── data_catalog.md                 # Dataset catalog with column descriptions
│   ├── naming-conventions.md           # Naming rules for schemas, tables and columns
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│   └── analytics/                      # KPI queries and reporting SQL
│
├── tests/                              # Data quality checks and validation scripts
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information
├── requirements.txt                    # Dependencies and requirements for the project
└── .gitignore                          # Files and folders ignored by Git

```
---

## Methodology

This project follows a structured, engineering-oriented workflow similar to real-world Data Warehouse development.
The focus is on reproducibility, explicit schema design, and business-oriented analytical output.

### Data Architecture

The warehouse follows the Medallion Architecture pattern:

- Bronze Layer: Raw source ingestion (as-is)
- Silver Layer: Cleansed and standardized integrated data
- Gold Layer: Business-ready dimensional model optimized for analytics

This layered approach improves traceability and allows transformations to remain transparent and testable.

### Data Sources

The project is based on the official Microsoft AdventureWorks dataset, which represents a fictional manufacturing and sales company. It contains realistic ERP-like structures including customers, products, orders, and sales transactions.

### Bronze Layer (Raw Ingestion)

The Bronze layer stores raw source data with minimal transformation.

Key principles:

- Preserve original source structure  
- Enable full traceability back to the raw input  
- Provide a stable base for downstream cleansing  


### Silver Layer (Cleansing and Standardization)

The Silver layer transforms Bronze data into a consistent and usable format.

Typical transformations include:

- Null handling and missing value resolution  
- Standardization of naming and formats  
- Data type normalization  
- Deduplication logic  

This layer represents the first integrated and quality-controlled dataset.


### Gold Layer (Dimensional Modeling)

The Gold layer contains the final business-ready data model.

It is modeled using a star schema, consisting of:

- Fact tables (e.g. sales transactions, order metrics)
- Dimension tables (e.g. customers, products, dates)

This schema is optimized for reporting, aggregation, and KPI computation.

### Analytics Layer (SQL KPI Queries)

Once the Gold layer is stable, business-focused KPI queries are built directly on top of the star schema.

This includes metrics such as:

- Revenue trends
- Customer segmentation performance
- Product profitability
- Sales growth and seasonal patterns
- Order volume and conversion metrics

These queries act as the foundation for reporting and BI dashboards.

---

## Tools & Technologies

- SQL Server Express  
- SQL Server Management Studio (SSMS)  
- T-SQL  
- Draw.io (architecture and data model diagrams)  

Optional extensions may include:

- Power BI (dashboarding)
- Python (automation, testing, ingestion scripting)

---

## Key Features

- Multi-layer Data Warehouse architecture (Bronze/Silver/Gold)
- Integration of multiple source systems 
- Cleansing and transformation logic implemented in SQL
- Star schema dimensional modeling for analytics
- Business KPI queries implemented in SQL
- Clean project structure and documentation

---

## Project Status

In progress. The project is developed incrementally with a clear phased approach. 

Current focus:

- Setting up the database environment, exploring the AdventureWorks source schema, and defining the first warehouse model.

Planned next steps:

- Bronze ingestion pipeline  
- Silver cleansing and standardization logic  
- Gold dimensional model implementation 
- Implement KPI queries in SQL (Analytics scripts)  
- Add documentation of key business metrics  
- Phase 2: Create a Power BI dashboard based on the Gold layer semantic model  

---

## Quickstart

1. Install required tools:
- SQL Server Express
- SQL Server Management Studio (SSMS)

2. Clone the repository:

```bash
git clone https://github.com/M-Kroll/sql-data-warehouse-project
cd sql-data-warehouse-project
```
3. Import datasets
- [AdventureWorks Sample Database (Microsoft Documentation)](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms)
4. Run SQL scripts in order:
- scripts/bronze/
- scripts/silver/
- scripts/gold/

5. Execute KPI queries:
- scripts/analytics/

---

## Author

Matthias Kroll

---

## License

Code is licensed under the MIT License. See LICENSE for details.
