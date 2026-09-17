data "aws_caller_identity" "current" {}

locals {
  uc_bucket_name = "sk-databricks-uc-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
}

resource "aws_s3_bucket" "uc_data" {
  bucket = local.uc_bucket_name
}

resource "aws_s3_bucket_versioning" "uc_data" {
  bucket = aws_s3_bucket.uc_data.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "uc_data" {
  bucket = aws_s3_bucket.uc_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "uc_data" {
  bucket = aws_s3_bucket.uc_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
