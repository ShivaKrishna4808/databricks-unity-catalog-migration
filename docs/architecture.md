# Architecture

## Databricks Unity Catalog Migration on AWS

```mermaid
flowchart TD

    A[AWS S3] --> B[AWS IAM Role]
    B --> C[Databricks Storage Credential]

    C --> D[finance_external]
    C --> E[sales_external]
    C --> F[shared_external]

    D --> G[Finance Catalog]
    E --> H[Sales Catalog]
    F --> I[Shared Catalog]

    G --> G1[finance.raw]
    G1 --> G2[finance.curated]

    H --> H1[sales.raw]
    H1 --> H2[sales.analytics]

    G2 --> J[shared.reporting]
    H2 --> J

    J --> K[customer_summary]
    J --> L[migration_validation_results]
    J --> M[audit_activity_24h]

    N[Data Engineers] --> G
    N --> H

    O[Data Analysts] --> J

    P[Terraform] --> A
    P --> B
    P --> C
    P --> D
    P --> E
    P --> F
    P --> G
    P --> H
    P --> I

    Q[GitHub Actions] --> P
