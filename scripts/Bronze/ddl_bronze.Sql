-- create table for bronze crm customer info--
IF OBJECT_id('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT          ,
    cst_key             NVARCHAR (50),
    cst_firstname       NVARCHAR (50),
    cst_lastname        NVARCHAR (50),
    cst_material_status NVARCHAR (50),
    cst_gndr            NVARCHAR (50),
    cst_create_date     DATE         
);

-- create table for bronze crm product info--
IF OBJECT_id('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
    prd_id         INT          ,
    prd_key        NVARCHAR (50),
    prd_name       NVARCHAR (50),
    prd_cost       INT          ,
    prd_line       NVARCHAR (50),
    prd_start_date DATETIME     ,
    prd_end_date   DATETIME     
);

-- create table for bronze crm sales details--
IF OBJECT_id('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num    NVARCHAR (50),
    sls_prd_key    NVARCHAR (50),
    sls_cust_id    INT          ,
    sls_order_date INT          ,
    sls_ship_date  INT          ,
    sls_due_date   INT          ,
    sls_sales      INT          ,
    sls_quantity   INT          ,
    sls_price      INT          
);

-- create table for bronze erp location a101--
IF OBJECT_id('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101 (
    cid     NVARCHAR (50),
    country NVARCHAR (50)
);

--create table for bronze erp customer az12
IF OBJECT_id('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
    cid   NVARCHAR (50),
    bdate DATE         ,
    gen   NVARCHAR (50)
);

-- create tabel for bronze erp px category g1v2
IF OBJECT_id('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id        NVARCHAR (50),
    cat       NVARCHAR (50),
    subcat    NVARCHAR (50),
    maintence NVARCHAR (50)
);
