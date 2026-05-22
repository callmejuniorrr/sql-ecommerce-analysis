-- ============================================
-- Cumulative revenue growth since first month
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : WITH RECURSIVE, LEFT JOIN, COALESCE,
--           SUM OVER, FIRST_VALUE, cumulative growth
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH RECURSIVE calendrier AS (

  -- Step 1: Generate all months from Sept 2016 to Oct 2018
  SELECT DATE '2016-09-01' AS mois

  UNION ALL

  SELECT mois + INTERVAL '1 month'
  FROM calendrier
  WHERE mois < '2018-10-30'

),

ca_mensuel AS (
  -- Step 2: Compute monthly revenue from Olist
  SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS mois,
    SUM(p.payment_value) AS ca
  FROM orders o
  JOIN order_payments p ON o.order_id = p.order_id
  GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)

),

enrichi AS (
  -- Step 3: LEFT JOIN calendar with revenue + compute cumulative sum
  SELECT
    c.mois,
    COALESCE(ROUND(v.ca, 2), 0) AS ca,
    ROUND(SUM(COALESCE(v.ca, 0)) OVER (
      ORDER BY c.mois
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS ca_cumulatif
  FROM calendrier c
  LEFT JOIN ca_mensuel v ON c.mois = v.mois
)

-- Step 4: Compute growth rate since first month using FIRST_VALUE
SELECT
  mois,
  ca,
  ca_cumulatif,
  FIRST_VALUE(ca) OVER (ORDER BY mois) AS ca_premier_mois,
  ROUND((ca_cumulatif - FIRST_VALUE(ca) OVER (ORDER BY mois))
    / FIRST_VALUE(ca) OVER (ORDER BY mois) * 100, 2) AS croissance
FROM enrichi;
