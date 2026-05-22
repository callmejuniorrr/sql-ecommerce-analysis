# E-Commerce SQL Analysis

Advanced SQL analysis on the Brazilian Olist e-commerce dataset,
covering window functions, CTEs, recursive queries, customer segmentation,
revenue growth, and complete monthly dashboards.

---

## Project Overview

This project explores customer purchasing behavior across Brazilian states
using advanced SQL techniques. Starting from raw transactional data (100k+ orders),
I built a series of queries covering customer ranking, market share calculation,
monthly growth analysis, state performance comparison, recursive calendars,
customer segmentation by revenue brackets, and cumulative growth tracking.

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

---

## SQL Concepts Covered

- **Window Functions** — RANK(), DENSE_RANK(), ROW_NUMBER(), SUM OVER(), AVG OVER(), LAG(), FIRST_VALUE()
- **PARTITION BY** — grouping without losing row-level detail
- **Chained CTEs** — breaking complex queries into readable steps
- **Recursive CTEs** — generating date series, numeric ranges, hierarchies
- **ROWS BETWEEN** — sliding window calculations
- **CASE WHEN Pivot** — transforming rows into columns
- **LEFT JOIN on range** — joining on conditions instead of equality
- **COALESCE** — replacing NULL values with defaults
- **EXTRACT** — extracting year/month from timestamps

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

---

## Sample Output — Cumulative Growth

| mois | ca | ca_cumulatif | ca_premier_mois | croissance |
|------|----|--------------|-----------------|------------|
| 2016-09 | 252.24 | 252.24 | 252.24 | 0.00% |
| 2016-10 | 59,090.48 | 59,342.72 | 252.24 | 23,426.17% |
| 2017-11 | 1,194,882.80 | 6,430,707.59 | 252.24 | 2,549,262.45% |

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

## Author

**Patrick Camy**
Data Analyst Student | Polytech Clermont-Ferrand
3rd year — Mathematical Engineering & Data Science

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/patrick-c-5267b4265)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github)](https://github.com/callmejuniorrr)
