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