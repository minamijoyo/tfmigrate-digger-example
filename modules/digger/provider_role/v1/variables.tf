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

variable "allowed_regions" {
  type        = list(string)
  description = "A list of allowed regions"
}

variable "override_policy_documents" {
  type        = list(string)
  default     = null
  description = "A list of override policies attached to the IAM role"
}
