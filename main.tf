resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.repo_prefix}-terraform-up-and-running-state"
  # Enable versioning so we can see the full revision history of our
  # state files
 
  force_destroy = true
  # Enable server-side encryption by default

}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    id = "versions_expiring"
      noncurrent_version_expiration {
        noncurrent_days = var.noncurrent_version_expiration_days
    }

    status = var.noncurrent_version_expiration_status
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
