# https://www.terraform.io/docs/backends/types/s3.html
resource "aws_s3_bucket" "this" {
  bucket        = var.s3_bucket_name
  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "this" {
  name                        = var.dynamodb_table_name
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = true
  hash_key                    = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
