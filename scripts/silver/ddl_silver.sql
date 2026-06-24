
-- ==============================================================================
-- Script:       Silver Layer DDL Setup (Final Version)
-- Description:  Creates cleansed and structured tables for the Silver layer.
--               Includes audit metadata (dwh_create_date) for tracking ingestion.
-- Author:       kush18KL
-- Date:         June 2026
-- ==============================================================================

USE DataWareHouse;
GO

-- ==============================================================================
-- 1. SOURCE SYSTEM: CRM TABLES
-- ==============================================================================

-- 1.1 Table: silver.crm_cust_info
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE silver.crm_cust_info (
    cust_id            INT,
    cst_key            NVARCHAR(50),
    cst_firstname      NVARCHAR(50),
    cst_lastname       NVARCHAR(50),
    cst_gndr           NVARCHAR(50),          
    cst_marital_status NVARCHAR(50),   
    cst_create_date    DATE,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO

-- 1.2 Table: silver.crm_prd_info
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO

CREATE TABLE silver.crm_prd_info (
    prd_id             INT,
    cat_id             NVARCHAR(50),
    prd_key            NVARCHAR(50),
    prd_nm             NVARCHAR(50),
    prd_cost           INT,
    prd_line           NVARCHAR(50),         
    prd_start_dt       DATETIME,
    prd_end_dt         DATETIME,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO

-- 1.3 Table: silver.crm_sales_details
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO

CREATE TABLE silver.crm_sales_details (
    sls_cust_id        INT,
    sls_ord_num        NVARCHAR(50),
    sls_prd_key        NVARCHAR(50),
    sls_order_dt       DATE,              
    sls_ship_dt        DATE,
    sls_due_dt         DATE,
    sls_quantity       INT,
    sls_sales          INT,
    sls_price          INT,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO


-- ==============================================================================
-- 2. SOURCE SYSTEM: ERP TABLES
-- ==============================================================================

-- 2.1 Table: silver.erp_loc_A101
IF OBJECT_ID('silver.erp_loc_A101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_A101;
GO

CREATE TABLE silver.erp_loc_A101 (
    cid                NVARCHAR(50),
    cntry              NVARCHAR(50),
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO

-- 2.2 Table: silver.erp_cust_az12
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;
GO

CREATE TABLE silver.erp_cust_az12 (
    cid                NVARCHAR(50),
    bdate              DATE,
    gen                NVARCHAR(50),
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO

-- 2.3 Table: silver.erp_px_cat_g1v2
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;
GO

CREATE TABLE silver.erp_px_cat_g1v2 (
    id                 NVARCHAR(50),
    cat                NVARCHAR(50),
    sucat              NVARCHAR(50),
    maintenance        NVARCHAR(50),
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO
