SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN transaction_value_category = 'HIGH_VALUE' THEN 1 ELSE 0 END) AS high_value,
  SUM(CASE WHEN transaction_value_category = 'MEDIUM_VALUE' THEN 1 ELSE 0 END) AS medium_value,
  SUM(CASE WHEN transaction_value_category = 'STANDARD' THEN 1 ELSE 0 END) AS standard_value
FROM finance.curated.transactions;
