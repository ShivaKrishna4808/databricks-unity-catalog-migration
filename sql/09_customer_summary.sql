CREATE OR REPLACE TABLE shared.reporting.customer_summary
USING DELTA
AS

WITH finance_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS transaction_count,
        ROUND(SUM(amount), 2) AS total_transaction_amount,
        SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END)
            AS completed_transactions
    FROM finance.curated.transactions
    GROUP BY customer_id
),

sales_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(CASE WHEN is_completed = true THEN 1 ELSE 0 END)
            AS completed_orders,
        ROUND(SUM(order_amount), 2) AS total_order_value,
        ROUND(
            SUM(
                CASE
                    WHEN is_completed = true THEN order_amount
                    ELSE 0
                END
            ),
            2
        ) AS completed_order_revenue
    FROM sales.analytics.orders
    GROUP BY customer_id
)

SELECT
    COALESCE(f.customer_id, s.customer_id) AS customer_id,

    COALESCE(f.transaction_count, 0) AS transaction_count,
    COALESCE(f.completed_transactions, 0) AS completed_transactions,
    COALESCE(f.total_transaction_amount, 0) AS total_transaction_amount,

    COALESCE(s.order_count, 0) AS order_count,
    COALESCE(s.completed_orders, 0) AS completed_orders,
    COALESCE(s.total_order_value, 0) AS total_order_value,
    COALESCE(s.completed_order_revenue, 0) AS completed_order_revenue,

    ROUND(
        COALESCE(f.total_transaction_amount, 0)
        + COALESCE(s.completed_order_revenue, 0),
        2
    ) AS customer_value,

    CASE
        WHEN
            COALESCE(f.total_transaction_amount, 0)
            + COALESCE(s.completed_order_revenue, 0) >= 3000
            THEN 'PLATINUM'

        WHEN
            COALESCE(f.total_transaction_amount, 0)
            + COALESCE(s.completed_order_revenue, 0) >= 1500
            THEN 'GOLD'

        ELSE 'STANDARD'
    END AS customer_segment,

    current_timestamp() AS reporting_updated_at

FROM finance_summary f

FULL OUTER JOIN sales_summary s
    ON f.customer_id = s.customer_id;
