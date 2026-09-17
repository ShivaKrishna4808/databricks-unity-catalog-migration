SELECT
  service_name,
  action_name,
  COUNT(*) AS event_count,
  COUNT(DISTINCT user_identity.email) AS unique_users,
  MIN(event_time) AS first_event,
  MAX(event_time) AS latest_event
FROM system.access.audit
WHERE event_time >= current_timestamp() - INTERVAL 24 HOURS
GROUP BY service_name, action_name
ORDER BY event_count DESC;
