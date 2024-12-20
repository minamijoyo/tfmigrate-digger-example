variable "name" {
  type        = string
  description = "IAM role name"
}

variable "account_id" {
  type        = string
  description = "AWS account ID"
}

variable "subjects" {
  type        = list(string)
  description = "A list of sub in the OIDC token of GitHub Actions (partial match if sub contains `*`)"
}

variable "roles_to_assume" {
  type        = list(string)
  description = "A list of IAM role names to assume"
}

variable "tfplan_bucket_name" {
  type        = string
  description = "S3 bucket name for tfplan"
}
