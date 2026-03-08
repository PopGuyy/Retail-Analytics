-- Project: Retail Chain Sales Analytics Platform
-- Module: Star Schema Design
-- Author: Aditya Prakash Acharya

CREATE WAREHOUSE retail_wh
WITH WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE;

USE WAREHOUSE retail_wh;

-- Step 1: Create Database
CREATE DATABASE retail_dw;
USE DATABASE retail_dw;

-- Step 2: Create Schema
CREATE SCHEMA retail;
USE SCHEMA retail;

-- Step 3: Create Date Dimension Table
-- Stores calendar information for time-based analysis
CREATE OR REPLACE TABLE dim_date (
    order_date DATE PRIMARY KEY,
    day NUMBER,
    month NUMBER,
    month_name STRING,
    year NUMBER,
    quarter NUMBER,
    weekday STRING
);
-- Step 4: Create Customer Dimension Table
-- Stores customer information for customer segmentation and analysis
CREATE OR REPLACE TABLE dim_customer (
    customer_id STRING PRIMARY KEY,
    customer_name STRING,
    segment STRING,
    country STRING,
    city STRING,
    state STRING,
    postal_code STRING,
    region STRING
);
-- Step 5: Create Product Dimension Table
-- Stores product and category information
CREATE OR REPLACE TABLE dim_product (
    product_id STRING PRIMARY KEY,
    category STRING,
    sub_category STRING,
    product_name STRING
);


-- Step 6: Create Fact Sales Table
-- Stores transactional sales data
-- Contains foreign keys referencing dimension tables
CREATE OR REPLACE TABLE fact_sales (
    order_id STRING,
    customer_id STRING,
    product_id STRING,
    order_date DATE,
    sales NUMBER(10,2),
    quantity NUMBER,
    discount NUMBER(5,2),
    profit NUMBER(10,2)
);

SELECT CURRENT_WAREHOUSE();

CREATE OR REPLACE FILE FORMAT retail_csv_format
TYPE = 'CSV'
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
SKIP_HEADER = 1
NULL_IF = ('NULL', 'null', '');


-- Optional Validation Query
-- Ensures proper star schema relationships
SELECT COUNT(*)
FROM FACT_SALES F
JOIN DIM_CUSTOMER C ON F.CUSTOMER_ID = C.CUSTOMER_ID
JOIN DIM_PRODUCT P ON F.PRODUCT_ID = P.PRODUCT_ID
JOIN DIM_DATE D ON F.ORDER_DATE = D.ORDER_DATE;