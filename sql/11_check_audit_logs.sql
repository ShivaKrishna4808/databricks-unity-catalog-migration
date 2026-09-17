SELECT
  event_time,
  service_name,
  action_name,
  user_identity.email AS user_email
FROM system.access.audit
ORDER BY event_time DESC
LIMIT 10;
