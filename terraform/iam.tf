
locals {
  uc_role_name = "databricks-unity-catalog-access"

  databricks_uc_role_arn = "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"

  databricks_external_id = var.databricks_external_id
}

data "aws_iam_policy_document" "uc_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        local.databricks_uc_role_arn,
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.uc_role_name}"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        local.databricks_external_id
      ]
    }
  }
}

resource "aws_iam_role" "uc_access" {
  name               = local.uc_role_name
  description        = "Unity Catalog access to project S3 storage"
  assume_role_policy = data.aws_iam_policy_document.uc_assume_role.json
}

data "aws_iam_policy_document" "uc_s3_access" {

  statement {
    sid    = "UnityCatalogS3Access"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload"
    ]

    resources = [
      aws_s3_bucket.uc_data.arn,
      "${aws_s3_bucket.uc_data.arn}/*"
    ]
  }

  statement {
    sid    = "UnityCatalogSelfAssume"
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.uc_role_name}"
    ]
  }
}

resource "aws_iam_role_policy" "uc_s3_access" {
  name = "UnityCatalogS3Access"
  role = aws_iam_role.uc_access.id

  policy = data.aws_iam_policy_document.uc_s3_access.json
}
