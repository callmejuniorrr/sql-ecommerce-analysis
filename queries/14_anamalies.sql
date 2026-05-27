-- ============================================
-- Payment anomaly detection : Z-score & IQR methods
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : CTEs, STDDEV, CROSS JOIN, Z-score, PERCENTILE_CONT, IQR
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH stat AS (
  -- Step 1: Compute mean and standard deviation of payment values
  SELECT
    AVG(payment_value) AS moyenne,
    STDDEV(payment_value) AS ecart_type
  FROM order_payments
),

anomalies AS (
  -- Step 2: Compute Z-score for each payment
  SELECT
    p.order_id,
    p.payment_value,
    s.moyenne,
    s.ecart_type,
    ROUND((p.payment_value - s.moyenne) / s.ecart_type, 2) AS z_score
  FROM order_payments p
  CROSS JOIN stat s
),

percentiles AS (
  -- Step 3: Compute Q1 and Q3 for IQR method
  SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY payment_value) AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY payment_value) AS q3
  FROM order_payments
)

-- Step 4: Detect anomalies using both methods
-- Method 1 : Z-score > 3
SELECT
  'Z-score' AS method,
  order_id,
  payment_value,
  z_score AS score,
  NULL AS seuil_haut
FROM anomalies
WHERE ABS(z_score) > 3

UNION ALL

-- Method 2 : IQR
SELECT
  'IQR' AS method,
  p.order_id,
  p.payment_value,
  NULL AS score,
  ROUND(pt.q3 + 1.5 * (pt.q3 - pt.q1), 2) AS seuil_haut
FROM order_payments p
CROSS JOIN percentiles pt
WHERE p.payment_value > pt.q3 + 1.5 * (pt.q3 - pt.q1)

ORDER BY payment_value DESC;
