 /*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/
-- =============================================================================
-- Create Dimension: gold.dim_customer
-- =============================================================================

IF OBJECT_ID('gold.dim_customer', 'V') IS NOT NULL
    DROP VIEW gold.dim_customer;
GO
CREATE VIEW gold.dim_customer
AS
SELECT row_number() OVER (ORDER BY cst_id) AS customer_key,
       ci.cst_id AS customer_id,
       ci.cst_key AS customer_number,
       ci.cst_firstname AS first_name,
       ci.cst_lastname AS last_name,
       CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr ELSE COALESCE (cd.gen, 'n/a') END AS gender,
       loc.country,
       ci.cst_marital_status AS marital_status,
       cd.bdate AS birthdate,
       ci.cst_create_date AS create_date
FROM   SILVER.crm_cust_info AS ci
       LEFT OUTER JOIN
       SILVER.erp_cust_az12 AS cd
       ON ci.cst_key = cd.cid
       LEFT OUTER JOIN
       SILVER.erp_loc_a101 AS loc
       ON ci.cst_key = loc.cid;
go


-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================

IF OBJECT_ID('gold.dim_product', 'V') IS NOT NULL
    DROP VIEW gold.dim_product;
GO

create view gold.dim_product as
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_date, pn.prd_key) AS product_key, -- Surrogate key
    pn.prd_id       AS product_id,
    pn.prd_key      AS product_number,
    pn.prd_name       AS product_name,
    pn.cat_id       AS category_id,
    pc.cat          AS category,
    pc.subcat       AS subcategory,
    pc.maintence  AS maintenance,
    pn.prd_cost     AS cost,
    pn.prd_line     AS product_line,
    pn.prd_start_date AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
    where pn.prd_end_date is null -- filter out
go

-- =============================================================================
-- Create Dimension: gold.fact_sales
-- =============================================================================

IF OBJECT_ID('gold.fact_sale', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sale AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_date AS order_date,
    sd.sls_ship_date  AS shipping_date,
    sd.sls_due_date  AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_product pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customer cu
    ON sd.sls_cust_id = cu.customer_id;

go
