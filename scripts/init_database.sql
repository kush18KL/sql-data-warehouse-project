-- ==============================================================================
-- Project:      Medallion Architecture Data Warehouse Setup
-- Description:  Initializes the 'DataWareHouse' database and sets up the 
--               logical schema layers (Bronze, Silver, Gold) for data processing.
-- Author:       kush18KL
-- Date:         June 2026
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. Database Creation & Initialization
-- ------------------------------------------------------------------------------

-- Create the central Data Warehouse database if it doesn't already exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN
    CREATE DATABASE DataWareHouse;
    PRINT 'Database "DataWareHouse" created successfully.';
END
ELSE
BEGIN
    PRINT 'Database "DataWareHouse" already exists.';
END
GO

-- Switch context to the target database
USE DataWareHouse;
GO

-- ------------------------------------------------------------------------------
-- 2. Medallion Layer Schema Definitions
-- ------------------------------------------------------------------------------

-- BRONZE LAYER (Raw / Ingestion)
-- Purpose: Acts as the landing zone for raw, unaltered data straight from source systems.
-- Characteristics: Appends only, retains history, no transformations applied.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
BEGIN
    EXEC('CREATE SCHEMA bronze;');
    PRINT 'Schema "bronze" created successfully.';
END
GO

-- SILVER LAYER (Cleansed / Enriched / Conformed)
-- Purpose: The operational data layer where data is deduplicated, validated, and normalized.
-- Characteristics: Handles missing values, enforces data types, and joins initial structures.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
BEGIN
    EXEC('CREATE SCHEMA silver;');
    PRINT 'Schema "silver" created successfully.';
END
GO

-- GOLD LAYER (Curated / Business / Reporting)
-- Purpose: The presentation layer optimized for BI tools, analytics, and business logic.
-- Characteristics: Uses Dimensional Modeling (Stars/Snowflakes), aggregated metrics, and fast query performance.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
BEGIN
    EXEC('CREATE SCHEMA gold;');
    PRINT 'Schema "gold" created successfully.';
END
GO

-- ------------------------------------------------------------------------------
-- End of Script
-- ------------------------------------------------------------------------------
