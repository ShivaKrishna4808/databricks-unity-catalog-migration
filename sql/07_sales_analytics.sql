CREATE OR REPLACE TABLE sales.analytics.orders
USING DELTA
AS
SELECT
  order_id,
  customer_id,
  order_date,
  UPPER(product) AS product,
  quantity,
  CAST(order_amount AS DECIMAL(12,2)) AS order_amount,

  CAST(order_amount / quantity AS DECIMAL(12,2)) AS unit_price,

  UPPER(status) AS status,

  CASE
    WHEN order_amount >= 1000 THEN 'HIGH_VALUE'
    WHEN order_amount >= 500 THEN 'MEDIUM_VALUE'
    ELSE 'STANDARD'
  END AS revenue_category,

  CASE
    WHEN UPPER(status) = 'COMPLETED' THEN true
    ELSE false
  END AS is_completed,

  current_timestamp() AS analytics_processed_at

FROM sales.raw.orders

WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND quantity > 0
  AND order_amount > 0;
