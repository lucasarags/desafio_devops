variable "alb_security_group_name" {
  description = "Name of the ALB security group"
  type        = string
}

variable "asg_security_group_name" {
  description = "Name of the ASG security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}