-- Module: Snowflake Performance Optimization & Advanced Features
-- Project: Retail Chain Sales Analytics Platform
-- Author: Aditya Prakash Acharya


USE ROLE ACCOUNTADMIN;
USE WAREHOUSE RETAIL_WH;
USE DATABASE RETAIL_DW;
USE SCHEMA RETAIL;


-- Table Clustering for Performance Optimization


SELECT COUNT(*) FROM FACT_SALES;

ALTER TABLE FACT_SALES
CLUSTER BY (ORDER_DATE);

SELECT SYSTEM$CLUSTERING_INFORMATION('FACT_SALES');


-- Demonstrating Time Travel Capability
-- (Restoring data using historical snapshot)


CREATE OR REPLACE TABLE FACT_SALES_RESTORED AS
SELECT *
FROM FACT_SALES
AT (OFFSET => -300);  

SELECT COUNT(*) FROM FACT_SALES_RESTORED;


-- Semi-Structured Data Handling using VARIANT


CREATE OR REPLACE TABLE CUSTOMER_JSON (
    CUSTOMER_ID STRING,
    CUSTOMER_INFO VARIANT
);

INSERT INTO CUSTOMER_JSON (CUSTOMER_ID, CUSTOMER_INFO)
SELECT 'C001', PARSE_JSON('{"name":"Shubh","city":"Bhubaneswar","membership":"Gold","spend":25000}')
UNION ALL
SELECT 'C002', PARSE_JSON('{"name":"Rahul","city":"Delhi","membership":"Silver","spend":15000}');

SELECT 
    CUSTOMER_ID,
    CUSTOMER_INFO:name::STRING AS NAME,
    CUSTOMER_INFO:city::STRING AS CITY,
    CUSTOMER_INFO:membership::STRING AS MEMBERSHIP,
    CUSTOMER_INFO:spend::NUMBER AS SPEND
FROM CUSTOMER_JSON;