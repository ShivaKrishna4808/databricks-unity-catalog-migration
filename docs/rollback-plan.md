# Unity Catalog Rollback Plan

## Objective

Provide a controlled recovery path if validation, permissions, or downstream workloads fail during or after the Unity Catalog migration.

## Rollback Triggers

Rollback may be required if:

- Source and target row counts do not reconcile
- Data-quality validation fails
- Required users lose access
- Unauthorized access is detected
- Reporting workloads fail after cutover
- Storage or IAM integration becomes unavailable

## Rollback Procedure

### 1. Stop Cutover

- Pause new writes to the migrated target objects
- Prevent additional production workloads from switching to the new Unity Catalog objects
- Record the failure condition and affected assets

### 2. Restore Workload Routing

- Redirect consumers back to the previous source objects
- Restore previous table or schema references
- Confirm critical reporting workloads execute successfully

### 3. Restore Access

- Reapply the previous access-control model if required
- Remove incorrect Unity Catalog grants
- Verify required users can access the original environment

### 4. Validate Source State

Confirm that the original source remains intact:

- Row counts
- Schema definitions
- Required tables
- Permissions
- Storage paths

### 5. Investigate Failure

Identify the cause before attempting another migration:

- Data mismatch
- IAM configuration
- Storage credential issue
- External location permissions
- Unity Catalog grants
- Transformation logic
- Downstream dependency failure

## Data Protection

The migration does not delete the original source data during validation.

Source assets remain available until:

- Migration validation passes
- Access testing passes
- Reporting workloads are verified
- The cutover is formally accepted

## Recovery Validation

After rollback:

- Verify source row counts
- Verify application and reporting access
- Verify user permissions
- Confirm no unauthorized writes occurred
- Review audit activity for the rollback window

## Reattempt Criteria

Migration should only be attempted again after:

- Root cause is identified
- Corrective changes are tested
- Validation checks pass
- RBAC is verified
- Terraform configuration reports expected state
