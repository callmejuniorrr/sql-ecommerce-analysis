-- ============================================
-- Market Share Analysis by Customer & State
-- Dataset : Olist Brazilian E-Commerce (Kaggle)
-- Skills  : CTEs, Window Functions (RANK, SUM OVER)
-- Author  : Patrick Camy 
-- Date    : Mai 2026
-- ============================================

-- Step 1 : Aggregate total revenue per customer
WITH ca_par_client AS (
  SELECT
    c.customer_id,
    c.customer_state,
    SUM(p.payment_value) AS ca_total
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_payments p ON o.order_id = p.order_id
  GROUP BY c.customer_id, c.customer_state
),

-- Step 2 : Rank customers by revenue within each state
--          and compute total revenue per state
part_de_marche_dans_etat AS (
  SELECT
    customer_id,
    customer_state,
    ca_total,
    RANK() OVER (
      PARTITION BY customer_state
      ORDER BY ca_total DESC
    ) AS rang_dans_etat,
    SUM(ca_total) OVER (
      PARTITION BY customer_state
    ) AS ca_total_par_etat
  FROM ca_par_client
)

-- Step 3 : Compute each customer's market share (%) within their state
SELECT
  customer_id,
  customer_state,
  ca_total,
  rang_dans_etat,
  ca_total_par_etat,
  (ca_total / ca_total_par_etat) * 100 AS part_de_marche_dans_etat
FROM part_de_marche_dans_etat
ORDER BY customer_state, rang_dans_etat;
