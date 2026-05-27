-- ============================================
-- Seller RFM segmentation
-- Dataset : Olist Brazilian E-Commerce
-- Skills  : CTEs, NTILE, CASE WHEN, RFM analysis
-- Author  : Patrick Camy
-- Date    : Mai 2026
-- ============================================

WITH rfm_brut AS (
  -- Step 1: Compute recency, frequency and monetary value per seller
  SELECT
    oi.seller_id,
    DATEDIFF('day',
      MAX(o.order_purchase_timestamp),
      (SELECT MAX(order_purchase_timestamp) FROM orders)
    ) AS recence,
    COUNT(oi.order_id) AS frequence,
    ROUND(SUM(p.payment_value), 2) AS montant
  FROM order_items oi
  JOIN orders o ON oi.order_id = o.order_id
  JOIN order_payments p ON oi.order_id = p.order_id
  GROUP BY oi.seller_id
),

rfm_scores AS (
  -- Step 2: Score each dimension using NTILE(5)
  SELECT
    seller_id, recence, frequence, montant,
    NTILE(5) OVER (ORDER BY recence DESC) AS r_score,
    NTILE(5) OVER (ORDER BY frequence DESC) AS f_score,
    NTILE(5) OVER (ORDER BY montant DESC) AS m_score
  FROM rfm_brut
)

-- Step 3: Compute RFM total score and assign segment
SELECT
  seller_id,
  recence, frequence, montant,
  r_score, f_score, m_score,
  r_score + f_score + m_score AS rfm_total,
  CASE
    WHEN r_score >= 4 AND f_score >= 4 THEN 'Champions'
    WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyaux'
    WHEN r_score >= 4 AND f_score <= 2 THEN 'Nouveaux'
    WHEN r_score <= 2 AND f_score >= 3 THEN 'A risque'
    ELSE 'Ordinaires'
  END AS segment
FROM rfm_scores
ORDER BY rfm_total DESC;
