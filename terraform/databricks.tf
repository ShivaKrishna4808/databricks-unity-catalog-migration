resource "databricks_storage_credential" "uc_s3" {
  name = "portfolio_uc_s3"

  aws_iam_role {
    role_arn = aws_iam_role.uc_access.arn
  }

  comment = "AWS S3 storage credential for Unity Catalog portfolio project"
}

resource "databricks_external_location" "finance" {
  name            = "finance_external"
  url             = "s3://${aws_s3_bucket.uc_data.id}/external/finance"
  credential_name = databricks_storage_credential.uc_s3.id

  comment = "Governed finance data location for Unity Catalog portfolio project"
}

resource "databricks_external_location" "sales" {
  name            = "sales_external"
  url             = "s3://${aws_s3_bucket.uc_data.id}/external/sales"
  credential_name = databricks_storage_credential.uc_s3.id

  comment = "Governed sales data location for Unity Catalog portfolio project"
}

resource "databricks_external_location" "shared" {
  name            = "shared_external"
  url             = "s3://${aws_s3_bucket.uc_data.id}/external/shared"
  credential_name = databricks_storage_credential.uc_s3.id

  comment = "Shared governed data location for Unity Catalog portfolio project"
}

resource "databricks_catalog" "finance" {
  name         = "finance"
  comment      = "Finance domain catalog for Unity Catalog migration portfolio project"
  storage_root = "s3://${aws_s3_bucket.uc_data.id}/external/finance/managed"
}

resource "databricks_catalog" "sales" {
  name         = "sales"
  comment      = "Sales domain catalog for Unity Catalog migration portfolio project"
  storage_root = "s3://${aws_s3_bucket.uc_data.id}/external/sales/managed"
}

resource "databricks_catalog" "shared" {
  name         = "shared"
  comment      = "Shared domain catalog for cross-functional reporting"
  storage_root = "s3://${aws_s3_bucket.uc_data.id}/external/shared/managed"
}

resource "databricks_schema" "finance_raw" {
  catalog_name = databricks_catalog.finance.name
  name         = "raw"
  comment      = "Raw ingestion layer for finance data"
}

resource "databricks_schema" "finance_curated" {
  catalog_name = databricks_catalog.finance.name
  name         = "curated"
  comment      = "Validated and business-ready finance datasets"
}

resource "databricks_schema" "sales_raw" {
  catalog_name = databricks_catalog.sales.name
  name         = "raw"
  comment      = "Raw ingestion layer for sales data"
}

resource "databricks_schema" "sales_analytics" {
  catalog_name = databricks_catalog.sales.name
  name         = "analytics"
  comment      = "Analytics-ready sales datasets"
}

resource "databricks_schema" "shared_reporting" {
  catalog_name = databricks_catalog.shared.name
  name         = "reporting"
  comment      = "Cross-functional reporting datasets"
}
