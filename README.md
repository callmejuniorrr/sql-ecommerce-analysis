#  E-Commerce SQL Analysis

Advanced SQL analysis on the Brazilian Olist e-commerce dataset,
covering window functions, CTEs, customer ranking, market share analysis,
revenue growth, and complete monthly dashboards.

---

##  Project Overview

This project explores customer purchasing behavior across Brazilian states
using advanced SQL techniques. Starting from raw transactional data (100k+ orders),
I built a series of queries covering customer ranking, market share calculation,
monthly growth analysis, state performance comparison, and a complete business dashboard.

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
| `04_top_clients_par_mois.sql` | Top 3 customers per month using ROW_NUMBER() |
| `05_croissance_mensuelle.sql` | Monthly revenue growth rate using LAG() |
| `06_performance_par_etat.sql` | State revenue performance comparison 2017 vs 2018 |
| `07_analyse_complete.sql` | Complete monthly dashboard: growth, rank, cumulative revenue, sliding average |

---

##  SQL Concepts Covered

- **Window Functions** — RANK(), DENSE_RANK(), ROW_NUMBER(), SUM OVER(), AVG OVER(), LAG()
- **PARTITION BY** — grouping without losing row-level detail
- **Chained CTEs** — breaking complex queries into readable steps
- **ROWS BETWEEN** — sliding window calculations (3-month average)
- **CASE WHEN Pivot** — transforming rows into columns
- **EXTRACT** — extracting year/month from timestamps
- **Aggregate vs Window** — understanding when to use each

---

##  Key Business Questions Answered

1. Who are the top customers by revenue in each Brazilian state?
2. What is the total revenue generated per state?
3. What percentage of a state's revenue does each customer represent?
4. Who are the top 3 customers each month?
5. Which months had the highest revenue growth vs the previous month?
6. Which states grew the most between 2017 and 2018?
7. What does a complete monthly performance dashboard look like?

---

## Sample Output — Complete Monthly Dashboard

| mois | ca | ca_precedent | taux_croissance | rang_dans_annee | ca_cumulatif | moyenne_3_mois |
|------|----|--------------|-----------------|-----------------|--------------|----------------|
| 2017-03 | 449,863.60 | 291,908.01 | 54.11% | 9 | 939,350.13 | 293,419.88 |
| 2017-11 | 1,194,882.80 | 779,677.88 | 53.25% | 1 | 6,430,707.59 | 815,640.76 |
| 2018-01 | 1,115,004.18 | 878,401.48 | 26.93% | 2 | 8,424,113.25 | 1,062,609.65 |

---

##  How to Run

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

4. Run the queries in order from `01_` to `07_`

---

##  Author

**Patrick Camy**
Data Analyst Student | Polytech Clermont-Ferrand
3rd year — Mathematical Engineering & Data Science

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/patrick-c-5267b4265)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github)](https://github.com/callmejuniorrr)
