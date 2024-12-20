output "arn" {
  value       = aws_s3_bucket.this.arn
  description = "S3 bucket ARN"
}

output "name" {
  value       = aws_s3_bucket.this.id
  description = "S3 bucket name"
}
