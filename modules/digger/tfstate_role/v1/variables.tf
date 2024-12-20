variable "name" {
  type        = string
  description = "IAM role name"
}

variable "digger_account_id" {
  type        = string
  description = "AWS account ID for digger role"
}

variable "digger_gha_role" {
  type        = string
  description = "IAM role name for digger GitHub Actions"
}

variable "tfstate_bucket_name" {
  type        = string
  description = "S3 bucket name for tfstate"
}

variable "tflock_table_name" {
  type        = string
  description = "DynamoDB table name for tfstate lock"
}
