SELECT
    COUNT(*) AS customers,
    SUM(transaction_count) AS transactions,
    SUM(order_count) AS orders,
    ROUND(SUM(total_transaction_amount), 2) AS transaction_value,
    ROUND(SUM(total_order_value), 2) AS total_order_value,
    ROUND(SUM(completed_order_revenue), 2) AS completed_revenue,
    SUM(CASE WHEN customer_segment = 'PLATINUM' THEN 1 ELSE 0 END)
        AS platinum_customers,
    SUM(CASE WHEN customer_segment = 'GOLD' THEN 1 ELSE 0 END)
        AS gold_customers,
    SUM(CASE WHEN customer_segment = 'STANDARD' THEN 1 ELSE 0 END)
        AS standard_customers
FROM shared.reporting.customer_summary;
