-- ============================================
-- Daily revenue report for January 2018
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : WITH RECURSIVE, INTERVAL day, LEFT JOIN, COALESCE
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH RECURSIVE calendrier AS (

  -- Step 1: Generate all days in January 2018
  SELECT DATE '2018-01-01' AS jour

  UNION ALL

  SELECT jour + INTERVAL '1 day'
  FROM calendrier
  WHERE jour < '2018-01-31'

),

ca_journalier AS (
  -- Step 2: Compute daily revenue from Olist
  SELECT
    DATE_TRUNC('day', o.order_purchase_timestamp) AS jour,
    ROUND(SUM(p.payment_value), 2) AS ca
  FROM orders o
  JOIN order_payments p ON o.order_id = p.order_id
  GROUP BY DATE_TRUNC('day', o.order_purchase_timestamp)
)

-- Step 3: LEFT JOIN to include days with no sales (ca = 0)
SELECT
  c.jour,
  COALESCE(v.ca, 0) AS ca
FROM calendrier c
LEFT JOIN ca_journalier v ON c.jour = v.jour
ORDER BY c.jour;
