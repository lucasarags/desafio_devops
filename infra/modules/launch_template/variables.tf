variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
}

variable "launch_template_ec2_name" {
  description = "Name of the EC2 instance created from the launch template"
  type        = string
}



