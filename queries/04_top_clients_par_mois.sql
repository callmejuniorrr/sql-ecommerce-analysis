-- ============================================
-- Top 3 customers per month
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : ROW_NUMBER, PARTITION BY, CTEs
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH ca_client_mois AS (
  -- Step 1: Compute revenue per customer per month
  SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS mois,
    c.customer_id,
    c.customer_state,
    SUM(p.payment_value) AS ca
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_payments p ON o.order_id = p.order_id
  GROUP BY mois, c.customer_state, c.customer_id
),

classement AS (
  -- Step 2: Rank customers within each month by revenue
  SELECT
    mois,
    customer_id,
    customer_state,
    ca,
    ROW_NUMBER() OVER (
      PARTITION BY mois
      ORDER BY ca DESC
    ) AS rang
  FROM ca_client_mois
)

-- Step 3: Keep only the top 3 customers per month
SELECT
  mois,
  customer_id,
  customer_state,
  ROUND(ca, 2) AS ca
FROM classement
WHERE rang < 4
ORDER BY mois, rang;
