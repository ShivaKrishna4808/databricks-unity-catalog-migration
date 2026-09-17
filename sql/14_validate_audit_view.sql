SELECT
  service_name,
  action_name,
  event_count,
  unique_users,
  first_event,
  latest_event
FROM shared.reporting.audit_activity_24h
ORDER BY event_count DESC
LIMIT 10;
