-- ============================================
-- Complete monthly dashboard
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : CTEs, LAG, RANK, SUM cumulative,
--           AVG sliding window, EXTRACT
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
),

rang_dans_annee AS (
  -- Step 3: Rank each month within its year by revenue
  SELECT
    mois,
    EXTRACT(YEAR FROM mois) AS annee,
    ca,
    ca_precedent,
    taux_croissance,
    RANK() OVER (
      PARTITION BY EXTRACT(YEAR FROM mois)
      ORDER BY ca DESC
    ) AS rang_dans_annee
  FROM croissance
)

-- Step 4: Add cumulative revenue and 3-month sliding average
SELECT
  mois,
  ROUND(ca, 2) AS ca,
  ROUND(ca_precedent, 2) AS ca_precedent,
  taux_croissance,
  rang_dans_annee,
  ROUND(SUM(ca) OVER (
    ORDER BY mois
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ), 2) AS ca_cumulatif,
  ROUND(AVG(ca) OVER (
    ORDER BY mois
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ), 2) AS moyenne_3_mois
FROM rang_dans_annee
WHERE ca >= 1000
ORDER BY mois;
