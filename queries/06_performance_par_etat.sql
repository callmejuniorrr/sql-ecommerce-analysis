-- ============================================
-- State revenue performance: 2017 vs 2018
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : CASE WHEN pivot, CTEs, EXTRACT
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH ca_par_etat_annee AS (
  -- Step 1: Compute total revenue per state per year
  SELECT
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS annee,
    c.customer_state,
    SUM(p.payment_value) AS ca
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_payments p ON o.order_id = p.order_id
  GROUP BY annee, c.customer_state
),

ca_pivot AS (
  -- Step 2: Pivot years into separate columns (one row per state)
  SELECT
    customer_state,
    SUM(CASE WHEN annee = 2017 THEN ca END) AS ca_2017,
    SUM(CASE WHEN annee = 2018 THEN ca END) AS ca_2018
  FROM ca_par_etat_annee
  GROUP BY customer_state
)

-- Step 3: Compute variation and growth rate, filter and rank
SELECT
  customer_state,
  ROUND(ca_2017, 2) AS ca_2017,
  ROUND(ca_2018, 2) AS ca_2018,
  ROUND((ca_2018 - ca_2017), 2) AS variation,
  ROUND((ca_2018 - ca_2017) / ca_2017 * 100, 2) AS taux_croissance
FROM ca_pivot
WHERE ca_2017 IS NOT NULL
  AND ca_2018 IS NOT NULL
ORDER BY taux_croissance DESC;
