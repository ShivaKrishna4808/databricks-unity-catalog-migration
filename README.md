
# Databricks Unity Catalog Migration on AWS

Portfolio project demonstrating a governed Databricks platform on AWS using Unity Catalog, Terraform, IAM, S3, Delta Lake, RBAC, and migration validation.

## Current Project Scope

- AWS S3 storage foundation
- AWS IAM integration for Unity Catalog
- Databricks storage credential
- External locations for Finance, Sales, and Shared data
- Unity Catalog catalogs and schemas
- Raw, curated, analytics, and reporting tables
- Group-based RBAC
- Migration validation checks
- Terraform management of AWS and Databricks resources

## Architecture

```text
AWS S3
  |
  v
AWS IAM Role
  |
  v
Databricks Storage Credential
  |
  +--> finance_external
  +--> sales_external
  +--> shared_external
          |
          v
      Unity Catalog

finance
├── raw
└── curated

sales
├── raw
└── analytics

shared
└── reporting