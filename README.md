# 🛒 Retail Chain Sales Analytics Platform

**Author:** Aditya Prakash Acharya

A full end-to-end data engineering and analytics project built on **Snowflake**, **Python/Pandas**, and **Apache Spark**. This platform ingests raw retail sales data, transforms it into a star schema data warehouse, and enables advanced business intelligence through SQL analytics and real-time streaming.

---

## 📁 Project Structure

```
Retail-Analytics/
│
├── Data (Cleaned, Raw and Warehouse)/
│   ├── Raw data/
│   │   └── retail_sales_data.csv
│   ├── Cleaned data/
│   │   └── retail_sales_cleaned.csv
│   └── Warehouse/
│       ├── FACT_SALES.csv
│       ├── DIM_CUSTOMER.csv
│       ├── DIM_PRODUCT.csv
│       └── DIM_DATE.csv
│
├── ETL Pipeline/
│   └── etl_pipeline.ipynb
│
├── Apache_Spark_batch + streaming/
│   └── Apache_Spark_batch_streaming.ipynb
│
├── star_schema.sql
├── Advanced_sql_analytics.sql
├── Security_RBAC.sql
└── snowflake_optimization.sql
```

---

## 🏗️ Architecture Overview

```
Raw CSV Data
     ↓
ETL Pipeline (Pandas)
     ↓
Snowflake Data Warehouse (Star Schema)
     ↓
Advanced SQL Analytics + Apache Spark Streaming
```

---

## 🗃️ Star Schema Design

The data warehouse follows a classic **star schema** with one fact table and three dimension tables.

| Table | Type | Description |
|---|---|---|
| `FACT_SALES` | Fact | Transactional sales records |
| `DIM_CUSTOMER` | Dimension | Customer info, segments, regions |
| `DIM_PRODUCT` | Dimension | Product catalog with categories |
| `DIM_DATE` | Dimension | Calendar breakdown for time analysis |

**Run:** `star_schema.sql` — sets up the Snowflake warehouse, database, schema, and all tables.

---

## ⚙️ ETL Pipeline

Built with **Python + Pandas**, the ETL notebook (`etl_pipeline.ipynb`) performs:

- **Extract** — Reads dimension and fact CSVs into DataFrames
- **Transform** — Standardizes column names, converts date formats, enforces data types
- **Load** — Writes all tables to Snowflake using `write_pandas`

### Setup

Before running the notebook, configure your Snowflake credentials as environment variables:

**Windows (PowerShell):**
```powershell
setx SNOWFLAKE_USER "your_username"
setx SNOWFLAKE_PASSWORD "your_password"
setx SNOWFLAKE_ACCOUNT "your_account"
```

**Mac/Linux:**
```bash
export SNOWFLAKE_USER=your_username
export SNOWFLAKE_PASSWORD=your_password
export SNOWFLAKE_ACCOUNT=your_account
```

> ⚠️ Never hardcode credentials. Restart Jupyter after setting environment variables.

---

## 📊 Advanced SQL Analytics

`Advanced_sql_analytics.sql` contains four business intelligence queries using **window functions**:

| Query | Technique Used |
|---|---|
| Year-over-Year Sales Growth | `LAG()` |
| Top 3 Products Per Year | `RANK()` + `QUALIFY` |
| Customer Running Total Sales | Cumulative `SUM() OVER()` |
| Top 10% Customers by Revenue | `NTILE(10)` |

**Run after:** the star schema and ETL pipeline are complete.

---

## 🔒 Security & RBAC

`Security_RBAC.sql` implements **Role-Based Access Control** in Snowflake:

- **`ANALYST_ROLE`** — Read-only (`SELECT`) access to all tables
- **`MANAGER_ROLE`** — Full privileges on all tables
- **Data Masking Policy** — `SALES` column is hidden (`NULL`) for analysts; only managers and admins see real values

---

## ⚡ Apache Spark — Batch & Streaming

`Apache_Spark_batch_streaming.ipynb` demonstrates real-time data processing:

- Defines a strict schema for incoming retail CSV streams
- Reads live data from a `streaming_input/` folder using Spark Structured Streaming
- Aggregates **yearly total sales in real-time**
- Writes results using `foreachBatch` to a CSV sink with checkpointing
- Simulates a live stream by injecting 100-row batches from the cleaned dataset

---

## 🚀 Snowflake Performance Optimization

`snowflake_optimization.sql` covers three Snowflake-specific performance features:

- **Table Clustering** — Clusters `FACT_SALES` by `ORDER_DATE` for faster date-range queries
- **Time Travel** — Restores a historical snapshot of `FACT_SALES` using `AT (OFFSET => -300)`
- **Semi-Structured Data** — Demonstrates `VARIANT` column type and `PARSE_JSON` for flexible customer data

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| Snowflake | Cloud data warehouse |
| Python / Pandas | ETL pipeline |
| Apache Spark (PySpark) | Batch & streaming processing |
| SQL | Analytics and schema design |
| Jupyter Notebook | Interactive development |

---

## 📋 How to Run (In Order)

1. **Set up Snowflake credentials** (environment variables)
2. **Run** `star_schema.sql` — creates the warehouse and tables
3. **Run** `etl_pipeline.ipynb` — loads data into Snowflake
4. **Run** `Advanced_sql_analytics.sql` — execute business queries
5. **Run** `Security_RBAC.sql` — apply roles and masking policies
6. **Run** `snowflake_optimization.sql` — apply performance tuning
7. **Run** `Apache_Spark_batch_streaming.ipynb` — start the streaming pipeline

---

## 📄 License

This project is for educational and portfolio purposes.