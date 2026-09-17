provider "aws" {
  region = var.aws_region
}

provider "databricks" {
  profile = "portfolio"
}
