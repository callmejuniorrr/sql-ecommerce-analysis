# E-Commerce SQL Analysis

Advanced SQL analysis on the Brazilian Olist e-commerce dataset,
covering window functions, CTEs, recursive queries, customer segmentation,
cohort analysis, RFM segmentation, funnel analysis, anomaly detection,
and complete monthly dashboards.

---

## Project Overview

This project explores customer and seller behavior on the Olist Brazilian
e-commerce platform using advanced SQL techniques. Starting from raw
transactional data (100k+ orders), I built a series of queries covering
customer ranking, market share, monthly growth, state performance,
recursive calendars, seller cohorts, RFM segmentation, conversion funnels,
and payment anomaly detection.

---

## Dataset

[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

- 100,000+ orders from 2016 to 2018
- 9 relational tables
- Data on orders, payments, customers, products and sellers

---

## Tech Stack

![SQL](https://img.shields.io/badge/SQL-DuckDB-FFF000?style=flat&logo=duckdb&logoColor=black)
![DBeaver](https://img.shields.io/badge/Tool-DBeaver-372923?style=flat)

---

## Queries

| File | Description |
|------|-------------|
| `01_window_functions.sql` | Customer ranking by revenue per state using RANK() |
| `02_state_totals.sql` | Individual vs state-level revenue using SUM OVER() |
| `03_market_share.sql` | Market share (%) per customer within their state |
| `04_top_clients_par_mois.sql` | Top 3 customers per month using ROW_NUMBER() |
| `05_croissance_mensuelle.sql` | Monthly revenue growth rate using LAG() |
| `06_performance_par_etat.sql` | State revenue performance comparison 2017 vs 2018 |
| `07_analyse_complete.sql` | Complete monthly dashboard: growth, rank, cumulative, sliding average |
| `08_calendrier_recursif.sql` | Recursive calendar with complete monthly revenue and COALESCE |
| `09_categories_niveaux.sql` | Customer segmentation by revenue brackets using recursive ranges |
| `10_croissance_cumulee.sql` | Cumulative growth rate since first month using FIRST_VALUE |
| `11_cohortes.sql` | Seller cohort retention analysis using DATEDIFF |
| `12_rfm.sql` | Seller RFM segmentation using NTILE(5) and CASE WHEN |
| `13_funnel.sql` | Order conversion funnel: placed, approved, delivered, paid |
| `14_anomalies.sql` | Payment anomaly detection using Z-score and IQR methods |


---

## SQL Concepts Covered

- **Window Functions** — RANK(), DENSE_RANK(), ROW_NUMBER(), SUM OVER(), AVG OVER(), LAG(), FIRST_VALUE(), NTILE()
- **PARTITION BY** — grouping without losing row-level detail
- **Chained CTEs** — breaking complex queries into readable steps
- **Recursive CTEs** — generating date series, numeric ranges, hierarchies
- **ROWS BETWEEN** — sliding window calculations
- **CASE WHEN Pivot** — transforming rows into columns
- **LEFT JOIN on range** — joining on conditions instead of equality
- **COALESCE & NULLIF** — handling NULL values
- **CROSS JOIN** — joining without a common key for global stats
- **PERCENTILE_CONT** — computing quartiles for IQR method
- **STDDEV** — standard deviation for Z-score anomaly detection
- **Cohort Analysis** — tracking seller retention over time
- **RFM Segmentation** — recency, frequency, monetary scoring
- **Funnel Analysis** — conversion rates across order stages
- **EXTRACT & DATE_TRUNC** — date manipulation


---

## Key Business Questions Answered

1. Who are the top customers by revenue in each Brazilian state?
2. What is the total revenue generated per state?
3. What percentage of a state's revenue does each customer represent?
4. Who are the top 3 customers each month?
5. Which months had the highest revenue growth vs the previous month?
6. Which states grew the most between 2017 and 2018?
7. What does a complete monthly performance dashboard look like?
8. Which months had zero sales?
9. How are customers distributed across revenue brackets?
10. What is the cumulative growth since the first month?
11. How many sellers from each cohort are still active months later?
12. Which sellers are Champions, Loyal, At-risk or New based on RFM?
13. What is the conversion rate at each stage of the order funnel?
14. Which payments are statistically anomalous?
---

## Sample Output — Market Share Query

| customer_id | customer_state | ca_total | rang_dans_etat | ca_total_par_etat | part_de_marche |
|-------------|---------------|----------|----------------|-------------------|----------------|
| 711fff42... | AC            | 1251.70  | 1              | 19,680.62         | 6.36%          |
| cd281c1a... | AC            | 995.18   | 2              | 19,680.62         | 5.06%          |
| f23c4b53... | AC            | 905.93   | 3              | 19,680.62         | 4.60%          |

## Sample Output — Payment Anomaly Detection

| method | order_id | payment_value | score | seuil_haut |
|--------|----------|---------------|-------|------------|
| Z-score | 03caa2c0... | 13,664.08 | 62.12 | NULL |
| IQR | 03caa2c0... | 13,664.08 | NULL | 409.75 |

---

## How to Run

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Install [DBeaver](https://dbeaver.io) and create a DuckDB connection
3. Load the CSV files using DuckDB :

```sql
CREATE TABLE customers AS
SELECT * FROM read_csv_auto('your_path/olist_customers_dataset.csv');

CREATE TABLE orders AS
SELECT * FROM read_csv_auto('your_path/olist_orders_dataset.csv');

CREATE TABLE order_payments AS
SELECT * FROM read_csv_auto('your_path/olist_order_payments_dataset.csv');
```

4. Run the queries in order from `01_` to `10_`

---

## Related Project

Interactive dashboard built on top of these SQL queries :
[Olist E-Commerce Dashboard](https://olist-dashboard-ex2np7xznr8zqeba6n2fgp.streamlit.app/)

---

## Author

**Patrick Camy**
Data Analyst Student | Polytech Clermont-Ferrand
3rd year — Mathematical Engineering & Data Science

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/patrick-c-5267b4265)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github)](https://github.com/callmejuniorrr)
