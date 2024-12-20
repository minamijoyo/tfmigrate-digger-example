output "arn" {
  value       = aws_iam_role.this.arn
  description = "IAM role ARN"
}

output "name" {
  value       = aws_iam_role.this.name
  description = "IAM role name"
}
