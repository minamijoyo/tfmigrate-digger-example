variable "name" {
  type        = string
  description = "S3 bucket name"
}

variable "expiration_days" {
  type        = number
  description = "Number of days to retain data"
}
