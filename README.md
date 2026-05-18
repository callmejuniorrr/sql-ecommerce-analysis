#  E-Commerce SQL Analysis

Advanced SQL analysis on the Brazilian Olist e-commerce dataset,
covering window functions, CTEs, customer ranking, and market share analysis.

---

##  Project Overview

This project explores customer purchasing behavior across Brazilian states
using advanced SQL techniques. Starting from raw transactional data (100k+ orders),
I built a series of queries to rank customers by revenue, compute state-level totals,
and calculate each customer's market share within their state.

---

##  Dataset

[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

- 100,000+ orders from 2016 to 2018
- 9 relational tables
- Data on orders, payments, customers, products and sellers

---

##  Tech Stack

![SQL](https://img.shields.io/badge/SQL-DuckDB-FFF000?style=flat&logo=duckdb&logoColor=black)
![DBeaver](https://img.shields.io/badge/Tool-DBeaver-372923?style=flat)

---

##  Queries

| File | Description |
|------|-------------|
| `01_window_functions.sql` | Customer ranking by revenue per state using RANK() |
| `02_state_totals.sql` | Individual vs state-level revenue using SUM OVER() |
| `03_market_share.sql` | Market share (%) per customer within their state |

---

##  SQL Concepts Covered

- **Window Functions** — RANK(), DENSE_RANK(), ROW_NUMBER(), SUM OVER()
- **PARTITION BY** — grouping without losing row-level detail
- **Chained CTEs** — breaking complex queries into readable steps
- **Aggregate vs Window** — understanding when to use each

---

##  Key Business Questions Answered

1. Who are the top customers by revenue in each Brazilian state?
2. What is the total revenue generated per state?
3. What percentage of a state's revenue does each customer represent?

---

##  Sample Output — Market Share Query

| customer_id | customer_state | ca_total | rang_dans_etat | ca_total_par_etat | part_de_marche |
|-------------|---------------|----------|----------------|-------------------|----------------|
| 711fff42... | AC            | 1251.70  | 1              | 19,680.62         | 6.36%          |
| cd281c1a... | AC            | 995.18   | 2              | 19,680.62         | 5.06%          |
| f23c4b53... | AC            | 905.93   | 3              | 19,680.62         | 4.60%          |

---

##  How to Run

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Install [DBeaver](https://dbeaver.io) and create a DuckDB connection
3. Load the CSV files using DuckDB :

---

```sql
CREATE TABLE customers AS
SELECT * FROM read_csv_auto('your_path/olist_customers_dataset.csv');

CREATE TABLE orders AS
SELECT * FROM read_csv_auto('your_path/olist_orders_dataset.csv');

CREATE TABLE order_payments AS
SELECT * FROM read_csv_auto('your_path/olist_order_payments_dataset.csv');
```

4. Run the queries in order from `01_` to `03_`

---

##  Author
Patrick Camy
Data Analyst Student | Polytech Clermont-Ferrand  
3rd year — Mathematical Engineering & Data Science

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/patrick-c-5267b4265)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github)](https://github.com/callmejuniorrr)
