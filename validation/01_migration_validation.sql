
-- ============================================================
-- FINANCE VALIDATION
-- ============================================================

SELECT
    'finance' AS domain,

    (SELECT COUNT(*)
     FROM finance.raw.transactions) AS source_rows,

    (SELECT COUNT(*)
     FROM finance.curated.transactions) AS target_rows,

    (
        (SELECT COUNT(*) FROM finance.raw.transactions)
        -
        (SELECT COUNT(*) FROM finance.curated.transactions)
    ) AS row_difference;


-- ============================================================
-- SALES VALIDATION
-- ============================================================

SELECT
    'sales' AS domain,

    (SELECT COUNT(*)
     FROM sales.raw.orders) AS source_rows,

    (SELECT COUNT(*)
     FROM sales.analytics.orders) AS target_rows,

    (
        (SELECT COUNT(*) FROM sales.raw.orders)
        -
        (SELECT COUNT(*) FROM sales.analytics.orders)
    ) AS row_difference;


-- ============================================================
-- FINANCE NULL / KEY VALIDATION
-- ============================================================

SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE
            WHEN transaction_id IS NULL THEN 1
            ELSE 0
        END
    ) AS null_transaction_ids,

    SUM(
        CASE
            WHEN customer_id IS NULL THEN 1
            ELSE 0
        END
    ) AS null_customer_ids,

    SUM(
        CASE
            WHEN amount <= 0 THEN 1
            ELSE 0
        END
    ) AS invalid_amounts

FROM finance.curated.transactions;


-- ============================================================
-- FINANCE DUPLICATE VALIDATION
-- ============================================================

SELECT
    transaction_id,
    COUNT(*) AS duplicate_count

FROM finance.curated.transactions

GROUP BY transaction_id

HAVING COUNT(*) > 1;


-- ============================================================
-- SALES NULL / KEY VALIDATION
-- ============================================================

SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE
            WHEN order_id IS NULL THEN 1
            ELSE 0
        END
    ) AS null_order_ids,

    SUM(
        CASE
            WHEN customer_id IS NULL THEN 1
            ELSE 0
        END
    ) AS null_customer_ids,

    SUM(
        CASE
            WHEN quantity <= 0 THEN 1
            ELSE 0
        END
    ) AS invalid_quantities,

    SUM(
        CASE
            WHEN order_amount <= 0 THEN 1
            ELSE 0
        END
    ) AS invalid_amounts

FROM sales.analytics.orders;


-- ============================================================
-- SALES DUPLICATE VALIDATION
-- ============================================================

SELECT
    order_id,
    COUNT(*) AS duplicate_count

FROM sales.analytics.orders

GROUP BY order_id

HAVING COUNT(*) > 1;
