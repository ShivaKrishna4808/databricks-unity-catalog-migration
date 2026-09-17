SELECT
    domain,
    check_name,
    actual_value,
    expected_value,
    validation_status
FROM shared.reporting.migration_validation_results
ORDER BY domain, check_name;
