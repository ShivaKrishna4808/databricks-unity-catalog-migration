CREATE OR REPLACE TABLE finance.curated.transactions
USING DELTA
AS
SELECT
  transaction_id,
  customer_id,
  transaction_date,
  CAST(amount AS DECIMAL(12,2)) AS amount,
  UPPER(transaction_type) AS transaction_type,
  UPPER(status) AS status,

  CASE
    WHEN amount >= 1000 THEN 'HIGH_VALUE'
    WHEN amount >= 500 THEN 'MEDIUM_VALUE'
    ELSE 'STANDARD'
  END AS transaction_value_category,

  current_timestamp() AS curated_at

FROM finance.raw.transactions

WHERE transaction_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND amount > 0;
