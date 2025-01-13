variable "aws_profile" {
  type        = string
  description = "AWS profile name for authentication"
  default     = "arags"
}

variable "aws_region" {
  type        = string
  description = "AWS region where resources will be deployed"
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for Terraform state"
  default     = "runway-s3-bucket"
}

variable "dynamodb_table_name" {
  type        = string
  description = "Name of the dynamodb table for Terraform state"
  default     = "tfstate-dynamodb"
}