-- ============================================
-- Customer segmentation by revenue brackets
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : WITH RECURSIVE, LEFT JOIN on range, COALESCE, COUNT
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH RECURSIVE niveau AS (

  -- Step 1: Generate revenue brackets from 0 to 1000 by 100
  SELECT 0 AS n

  UNION ALL

  SELECT n + 100
  FROM niveau
  WHERE n < 1000

),

ca_client AS (

  -- Step 2: Compute total revenue per customer
  SELECT
    c.customer_id,
    SUM(p.payment_value) AS ca
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_payments p ON o.order_id = p.order_id
  GROUP BY c.customer_id

)

-- Step 3: LEFT JOIN on range condition to count clients per bracket
SELECT
  n.n AS tranche_min,
  n.n + 100 AS tranche_max,
  COUNT(v.customer_id) AS nb_clients,
  COALESCE(ROUND(SUM(v.ca), 2), 0) AS ca_total
FROM niveau n
LEFT JOIN ca_client v ON v.ca >= n.n AND v.ca < n.n + 100
GROUP BY n.n
ORDER BY n.n;
