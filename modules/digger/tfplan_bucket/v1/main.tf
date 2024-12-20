resource "aws_s3_bucket" "this" {
  bucket = var.name
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    id     = "remove-old"
    status = "Enabled"

    expiration {
      days = var.expiration_days
    }
  }
}
