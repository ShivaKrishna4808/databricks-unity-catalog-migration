CREATE OR REPLACE TABLE shared.reporting.migration_validation_results
USING DELTA
AS

WITH validation_checks AS (

    -- Finance row-count reconciliation
    SELECT
        'finance' AS domain,
        'row_count_difference' AS check_name,
        ABS(
            (SELECT COUNT(*) FROM finance.raw.transactions)
            -
            (SELECT COUNT(*) FROM finance.curated.transactions)
        ) AS actual_value,
        0 AS expected_value

    UNION ALL

    -- Finance null transaction IDs
    SELECT
        'finance',
        'null_transaction_ids',
        COUNT(*),
        0
    FROM finance.curated.transactions
    WHERE transaction_id IS NULL

    UNION ALL

    -- Finance null customer IDs
    SELECT
        'finance',
        'null_customer_ids',
        COUNT(*),
        0
    FROM finance.curated.transactions
    WHERE customer_id IS NULL

    UNION ALL

    -- Finance invalid amounts
    SELECT
        'finance',
        'invalid_amounts',
        COUNT(*),
        0
    FROM finance.curated.transactions
    WHERE amount <= 0

    UNION ALL

    -- Finance duplicate transaction IDs
    SELECT
        'finance',
        'duplicate_transaction_ids',
        COUNT(*),
        0
    FROM (
        SELECT transaction_id
        FROM finance.curated.transactions
        GROUP BY transaction_id
        HAVING COUNT(*) > 1
    )

    UNION ALL

    -- Sales row-count reconciliation
    SELECT
        'sales',
        'row_count_difference',
        ABS(
            (SELECT COUNT(*) FROM sales.raw.orders)
            -
            (SELECT COUNT(*) FROM sales.analytics.orders)
        ),
        0

    UNION ALL

    -- Sales null order IDs
    SELECT
        'sales',
        'null_order_ids',
        COUNT(*),
        0
    FROM sales.analytics.orders
    WHERE order_id IS NULL

    UNION ALL

    -- Sales null customer IDs
    SELECT
        'sales',
        'null_customer_ids',
        COUNT(*),
        0
    FROM sales.analytics.orders
    WHERE customer_id IS NULL

    UNION ALL

    -- Sales invalid quantities
    SELECT
        'sales',
        'invalid_quantities',
        COUNT(*),
        0
    FROM sales.analytics.orders
    WHERE quantity <= 0

    UNION ALL

    -- Sales invalid amounts
    SELECT
        'sales',
        'invalid_amounts',
        COUNT(*),
        0
    FROM sales.analytics.orders
    WHERE order_amount <= 0

    UNION ALL

    -- Sales duplicate order IDs
    SELECT
        'sales',
        'duplicate_order_ids',
        COUNT(*),
        0
    FROM (
        SELECT order_id
        FROM sales.analytics.orders
        GROUP BY order_id
        HAVING COUNT(*) > 1
    )
)

SELECT
    domain,
    check_name,
    actual_value,
    expected_value,

    CASE
        WHEN actual_value = expected_value THEN 'PASS'
        ELSE 'FAIL'
    END AS validation_status,

    current_timestamp() AS validation_timestamp

FROM validation_checks;
