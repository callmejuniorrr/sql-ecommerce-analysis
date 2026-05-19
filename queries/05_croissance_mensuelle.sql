-- ============================================
-- Monthly revenue growth rate
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : LAG, ROUND, CTEs, filtering
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH ca_mensuel AS (
  -- Step 1: Compute total revenue per month
  SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS mois,
    SUM(p.payment_value) AS ca
  FROM orders o
  JOIN order_payments p ON o.order_id = p.order_id
  GROUP BY mois
),

croissance AS (
  -- Step 2: Compute previous month revenue and growth rate
  SELECT
    mois,
    ca,
    LAG(ca) OVER (ORDER BY mois) AS ca_precedent,
    ROUND(
      (ca - LAG(ca) OVER (ORDER BY mois))
      / LAG(ca) OVER (ORDER BY mois) * 100
    , 2) AS taux_croissance
  FROM ca_mensuel
)

-- Step 3: Filter incomplete months and rank by growth rate
SELECT
  mois,
  ROUND(ca, 2) AS ca,
  ROUND(ca_precedent, 2) AS ca_precedent,
  taux_croissance
FROM croissance
WHERE ca >= 1000
  AND ca_precedent IS NOT NULL
ORDER BY taux_croissance DESC;
