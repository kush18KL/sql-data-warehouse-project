-- ==============================================================================
-- Stored Procedure: bronze.load_bronze
-- Description:      Orchestrates the Full Load ETL process for the Bronze Layer.
--                   It truncates existing staging tables and bulk inserts raw 
--                   data from CSV source files (CRM & ERP systems).
-- Author:           kush18KL
-- Date:             June 2026
-- ==============================================================================

CREATE OR ALTER PROCEDURE bronze.load_bronze
    @BaseFolder NVARCHAR(500) = 'C:\Users\hp\OneDrive\Desktop\C\sql-data-warehouse-project\datasets\'
AS
BEGIN
    SET NOCOUNT ON;

    -- Time tracking variables
    DECLARE @start_time DATETIME, 
            @end_time DATETIME, 
            @batch_start_time DATETIME, 
            @batch_end_time DATETIME;  
    
    -- Dynamic SQL variable to handle parameterized file paths
    DECLARE @sql NVARCHAR(MAX);

    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '============================================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '============================================================';

        -- ======================================================================
        -- SECTION 1: LOADING CRM TABLES
        -- ======================================================================
        PRINT '------------------------------------------------------------';
        PRINT 'LOADING CRM Tables';
        PRINT '------------------------------------------------------------';

        -- 1.1 Table: bronze.crm_cust_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> BULK INSERTING INTO: bronze.crm_cust_info';
        SET @sql = 'BULK INSERT bronze.crm_cust_info FROM ''' + @BaseFolder + 'source_crm\cust_info.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','', TABLOCK);';
        EXEC sp_executesql @sql;
    
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- 1.2 Table: bronze.crm_prd_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> BULK INSERTING INTO: bronze.crm_prd_info';
        SET @sql = 'BULK INSERT bronze.crm_prd_info FROM ''' + @BaseFolder + 'source_crm\prd_info.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','', TABLOCK);';
        EXEC sp_executesql @sql;

        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- 1.3 Table: bronze.crm_sales_details
        SET @start_time = GETDATE();
        PRINT '>> TRUNCATING Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> BULK INSERTING INTO: bronze.crm_sales_details';
        SET @sql = 'BULK INSERT bronze.crm_sales_details FROM ''' + @BaseFolder + 'source_crm\sales_details.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','', TABLOCK);';
        EXEC sp_executesql @sql;

        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';


        -- ======================================================================
        -- SECTION 2: LOADING ERP TABLES
        -- ======================================================================
        PRINT '------------------------------------------------------------';
        PRINT 'LOADING ERP Tables';
        PRINT '------------------------------------------------------------';
        
        -- 2.1 Table: bronze.erp_cust_az12
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> BULK INSERTING INTO: bronze.erp_cust_az12';
        SET @sql = 'BULK INSERT bronze.erp_cust_az12 FROM ''' + @BaseFolder + 'source_erp\CUST_AZ12.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','', TABLOCK);';
        EXEC sp_executesql @sql;

        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- 2.2 Table: bronze.erp_loc_A101
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_loc_A101';
        TRUNCATE TABLE bronze.erp_loc_A101;

        PRINT '>> BULK INSERTING INTO: bronze.erp_loc_A101';
        SET @sql = 'BULK INSERT bronze.erp_loc_A101 FROM ''' + @BaseFolder + 'source_erp\LOC_A101.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','', TABLOCK);';
        EXEC sp_executesql @sql;

        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- 2.3 Table: bronze.erp_px_cat_g1v2
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> BULK INSERTING INTO: bronze.erp_px_cat_g1v2';
        SET @sql = 'BULK INSERT bronze.erp_px_cat_g1v2 FROM ''' + @BaseFolder + 'source_erp\PX_CAT_G1V2.csv'' WITH (FIRSTROW = 2, FIELDTERMINATOR = '','', TABLOCK);';
        EXEC sp_executesql @sql;

        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Execution Summary
        SET @batch_end_time = GETDATE();
        PRINT '============================================================';
        PRINT 'LOADING BRONZE LAYER COMPLETED';
        PRINT 'TOTAL LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' Seconds';
        PRINT '============================================================';

    END TRY
    BEGIN CATCH
        PRINT '============================================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message:   ' + ERROR_MESSAGE();
        PRINT 'Error Number:    ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Severity:  ' + CAST(ERROR_SEVERITY() AS NVARCHAR);
        PRINT 'Error State:     ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT 'Error Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'N/A');
        PRINT '============================================================';
    END CATCH   
END;
GO
