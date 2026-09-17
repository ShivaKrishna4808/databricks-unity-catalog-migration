variable "aws_region" {
  description = "AWS region used by the portfolio environment"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Portfolio project name"
  type        = string
  default     = "databricks-unity-catalog-migration"
}

variable "databricks_external_id" {
  description = "External ID used by Databricks when assuming the Unity Catalog IAM role"
  type        = string
  sensitive   = true
}
