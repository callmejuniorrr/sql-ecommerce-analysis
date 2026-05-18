-- ============================================
-- Total Revenue per State
-- Dataset : Olist Brazilian E-Commerce (Kaggle)
-- Skills  : Window Functions (SUM OVER, PARTITION BY)
-- Author  : Ton Prénom Nom
-- Date    : Mai 2026
-- ============================================

-- For each customer, display their individual revenue
-- alongside the total revenue of their state
-- SUM OVER (PARTITION BY) keeps all rows unlike GROUP BY

WITH ca_par_client AS (

  -- Aggregate total revenue per customer
  SELECT
    c.customer_id,
    c.customer_state,
    SUM(p.payment_value) AS ca_total
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_payments p ON o.order_id = p.order_id
  GROUP BY c.customer_id, c.customer_state

)

SELECT
  customer_id,
  customer_state,
  ca_total,
  RANK() OVER (
    PARTITION BY customer_state
    ORDER BY ca_total DESC
  ) AS rang_dans_etat,
  SUM(ca_total) OVER (
    PARTITION BY customer_state
  ) AS ca_total_par_etat
FROM ca_par_client
ORDER BY customer_state, rang_dans_etat;
