variable "repo_prefix" {
  default = ""
  description = "S3 Repository prefix"
}

variable "noncurrent_version_expiration_days" {
  default = 30
  description = "how long (in days) we keep old files versions"
}

variable "noncurrent_version_expiration_status" {
  default = "Enabled"
  description = "Is the rule for old versions keeping enabled"
}

variable "dynamodb_table_name" {
  default = "terraform-up-and-running-locks"
  description = "DynamoDB table name"
}
