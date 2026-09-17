SELECT
    'finance' AS domain,
    (SELECT COUNT(*) FROM finance.raw.transactions) AS source_rows,
    (SELECT COUNT(*) FROM finance.curated.transactions) AS target_rows,
    (SELECT COUNT(*) FROM finance.raw.transactions)
      - (SELECT COUNT(*) FROM finance.curated.transactions)
      AS row_difference

UNION ALL

SELECT
    'sales',
    (SELECT COUNT(*) FROM sales.raw.orders),
    (SELECT COUNT(*) FROM sales.analytics.orders),
    (SELECT COUNT(*) FROM sales.raw.orders)
      - (SELECT COUNT(*) FROM sales.analytics.orders);
