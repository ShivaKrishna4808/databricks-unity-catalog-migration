SELECT
  COUNT(*) AS total_rows,

  SUM(CASE
        WHEN is_completed = true
        THEN 1 ELSE 0
      END) AS completed_orders,

  ROUND(
    SUM(CASE
          WHEN is_completed = true
          THEN order_amount
          ELSE 0
        END),
    2
  ) AS completed_revenue,

  SUM(CASE
        WHEN revenue_category = 'HIGH_VALUE'
        THEN 1 ELSE 0
      END) AS high_value,

  SUM(CASE
        WHEN revenue_category = 'MEDIUM_VALUE'
        THEN 1 ELSE 0
      END) AS medium_value,

  SUM(CASE
        WHEN revenue_category = 'STANDARD'
        THEN 1 ELSE 0
      END) AS standard_value

FROM sales.analytics.orders;
