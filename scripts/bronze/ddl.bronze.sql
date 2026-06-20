-- ==============================================================================
-- Script:       Bronze Layer DDL Setup
-- Description:  Creates the staging tables for the Bronze layer. These tables 
--               mirror the schema of raw files extracted from the source systems 
--               (CRM and ERP) without any modifications.
-- Author:       kush18KL
-- Date:         June 2026
-- ==============================================================================

USE DataWareHouse;
GO

-- ==============================================================================
-- 1. SOURCE SYSTEM: CRM TABLES
-- ==============================================================================

-- 1.1 Table: bronze.crm_cust_info
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cust_id            INT,
    cst_key            NVARCHAR(50),
    cst_firstname      NVARCHAR(50),
    cst_lastname       NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr           NVARCHAR(50),
    cst_create_date    DATE
);
GO

-- 1.2 Table: bronze.crm_prd_info
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id             INT,
    prd_key            NVARCHAR(50),
    prd_nm             NVARCHAR(50),
    prd_cost           INT,
    prd_line           VARCHAR(50),
    prd_start_dt       DATETIME,
    prd_end_dt         DATETIME
);
GO

-- 1.3 Table: bronze.crm_sales_details
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num        NVARCHAR(50),
    sls_prd_key        NVARCHAR(50),
    sls_cust_id        INT,
    sls_order_dt       INT,  -- Date key stored as integer (YYYYMMDD)
    sls_ship_dt        INT,  -- Date key stored as integer (YYYYMMDD)
    sls_due_dt         INT,  -- Date key stored as integer (YYYYMMDD)
    sls_sales          INT,
    sls_quantity       INT,
    sls_price          INT
);
GO


-- ==============================================================================
-- 2. SOURCE SYSTEM: ERP TABLES
-- ==============================================================================

-- 2.1 Table: bronze.erp_loc_A101
IF OBJECT_ID('bronze.erp_loc_A101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_A101;
GO

CREATE TABLE bronze.erp_loc_A101 (
    cid                NVARCHAR(50),
    cntry              NVARCHAR(50)
);
GO

-- 2.2 Table: bronze.erp_cust_az12
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid                NVARCHAR(50),
    bdate              DATE,
    gen                NVARCHAR(50)
);
GO

-- 2.3 Table: bronze.erp_px_cat_g1v2
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id                 NVARCHAR(50),
    cat                NVARCHAR(50),
    sucat              NVARCHAR(50),
    maintenance        NVARCHAR(50)
);
GO
