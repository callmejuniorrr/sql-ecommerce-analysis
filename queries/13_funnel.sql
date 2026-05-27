-- ============================================
-- Order conversion funnel analysis
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : CTEs, CASE WHEN, COUNT DISTINCT, conversion rates
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH etapes AS (
  -- Step 1: Count orders at each stage of the funnel
  SELECT
    COUNT(DISTINCT o.order_id) AS nb_commandes,
    COUNT(DISTINCT CASE WHEN o.order_status != 'canceled'
      THEN o.order_id END) AS nb_approuvees,
    COUNT(DISTINCT CASE WHEN o.order_status = 'delivered'
      THEN o.order_id END) AS nb_livrees,
    COUNT(DISTINCT CASE WHEN p.payment_value > 0
      THEN o.order_id END) AS nb_payees
  FROM orders o
  LEFT JOIN order_payments p ON o.order_id = p.order_id
)

-- Step 2: Compute conversion rates between each stage
SELECT
  nb_commandes,
  nb_approuvees,
  ROUND(nb_approuvees * 100.0 / nb_commandes, 2) AS taux_approbation,
  nb_livrees,
  ROUND(nb_livrees * 100.0 / nb_approuvees, 2) AS taux_livraison,
  nb_payees,
  ROUND(nb_payees * 100.0 / nb_commandes, 2) AS taux_conversion_global
FROM etapes;
