SELECT
  COUNT(*) AS total_rows,
  SUM(quantity) AS total_quantity,
  SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed,
  SUM(CASE WHEN status = 'PROCESSING' THEN 1 ELSE 0 END) AS processing,
  SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END) AS cancelled,
  ROUND(SUM(order_amount), 2) AS total_order_amount
FROM sales.raw.orders;
