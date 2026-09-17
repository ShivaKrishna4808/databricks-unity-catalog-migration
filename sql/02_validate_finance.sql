SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed,
  SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) AS pending,
  SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed,
  ROUND(SUM(amount), 2) AS total_amount
FROM finance.raw.transactions;
