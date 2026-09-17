CREATE OR REPLACE VIEW shared.reporting.audit_activity_24h AS
SELECT
    service_name,
    action_name,
    COUNT(*) AS event_count,
    COUNT(DISTINCT user_identity.email) AS unique_users,
    MIN(event_time) AS first_event,
    MAX(event_time) AS latest_event
FROM system.access.audit
WHERE event_time >= current_timestamp() - INTERVAL 24 HOURS
GROUP BY
    service_name,
    action_name;
