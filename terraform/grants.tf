# ============================================================
# DATA ENGINEERS - FINANCE
# ============================================================

resource "databricks_grant" "finance_engineers_catalog" {
  catalog = databricks_catalog.finance.name

  principal  = "uc_portfolio_data_engineers"
  privileges = ["USE_CATALOG"]
}

resource "databricks_grant" "finance_raw_engineers" {
  schema = databricks_schema.finance_raw.id

  principal = "uc_portfolio_data_engineers"

  privileges = [
    "USE_SCHEMA",
    "SELECT",
    "MODIFY",
    "CREATE_TABLE"
  ]
}

resource "databricks_grant" "finance_curated_engineers" {
  schema = databricks_schema.finance_curated.id

  principal = "uc_portfolio_data_engineers"

  privileges = [
    "USE_SCHEMA",
    "SELECT",
    "MODIFY",
    "CREATE_TABLE"
  ]
}

# ============================================================
# DATA ENGINEERS - SALES
# ============================================================

resource "databricks_grant" "sales_engineers_catalog" {
  catalog = databricks_catalog.sales.name

  principal  = "uc_portfolio_data_engineers"
  privileges = ["USE_CATALOG"]
}

resource "databricks_grant" "sales_raw_engineers" {
  schema = databricks_schema.sales_raw.id

  principal = "uc_portfolio_data_engineers"

  privileges = [
    "USE_SCHEMA",
    "SELECT",
    "MODIFY",
    "CREATE_TABLE"
  ]
}

resource "databricks_grant" "sales_analytics_engineers" {
  schema = databricks_schema.sales_analytics.id

  principal = "uc_portfolio_data_engineers"

  privileges = [
    "USE_SCHEMA",
    "SELECT",
    "MODIFY",
    "CREATE_TABLE"
  ]
}

# ============================================================
# DATA ANALYSTS - SHARED REPORTING
# ============================================================

resource "databricks_grant" "shared_analysts_catalog" {
  catalog = databricks_catalog.shared.name

  principal  = "uc_portfolio_data_analysts"
  privileges = ["USE_CATALOG"]
}

resource "databricks_grant" "shared_reporting_analysts" {
  schema = databricks_schema.shared_reporting.id

  principal = "uc_portfolio_data_analysts"

  privileges = [
    "USE_SCHEMA",
    "SELECT"
  ]
}
