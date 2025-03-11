resource "aws_s3_bucket" "terraform_state" {
  bucket              = "${var.repo_prefix}-terraform-up-and-running-state"
  force_destroy       = true
  object_lock_enabled = true

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
      sse_algorithm = "aws:kms"
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
