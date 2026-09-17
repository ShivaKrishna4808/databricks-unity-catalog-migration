# Unity Catalog Migration Plan

## Objective

Migrate data assets from a legacy Databricks-style environment into a governed Unity Catalog architecture on AWS.

## Migration Phases

### 1. Discovery

- Inventory existing tables and schemas
- Identify storage locations
- Review existing permissions
- Identify downstream dependencies

### 2. AWS Foundation

- Configure S3 storage
- Enable encryption
- Enable versioning
- Block public access
- Configure IAM role for Databricks

### 3. Unity Catalog Setup

- Create storage credential
- Create external locations
- Create catalogs
- Create schemas
- Configure RBAC

### 4. Data Migration

Finance:

```text
finance.raw.transactions
        ↓
finance.curated.transactions
