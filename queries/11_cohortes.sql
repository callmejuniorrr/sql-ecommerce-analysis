-- ============================================
-- Seller cohort retention analysis
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : CTEs, DATE_TRUNC, DATEDIFF, cohort analysis
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH premiere_vente AS (
  -- Step 1: Find the first sale month for each seller (= cohort)
  SELECT
    oi.seller_id,
    DATE_TRUNC('month', MIN(o.order_purchase_timestamp)) AS cohorte
  FROM order_items oi
  JOIN orders o ON oi.order_id = o.order_id
  GROUP BY oi.seller_id
),

vente AS (
  -- Step 2: Get all sales with their month for each seller
  SELECT
    oi.seller_id,
    DATE_TRUNC('month', o.order_purchase_timestamp) AS mois_vente
  FROM order_items oi
  JOIN orders o ON oi.order_id = o.order_id
)

-- Step 3: Join cohort with all sales, compute months since first sale
SELECT
  p.cohorte,
  v.mois_vente,
  DATEDIFF('month', p.cohorte, v.mois_vente) AS mois_depuis_premiere_vente,
  COUNT(DISTINCT v.seller_id) AS nb_vendeurs_actifs
FROM premiere_vente p
JOIN vente v ON p.seller_id = v.seller_id
GROUP BY p.cohorte, v.mois_vente, mois_depuis_premiere_vente
ORDER BY p.cohorte, mois_depuis_premiere_vente;
