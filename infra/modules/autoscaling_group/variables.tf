variable "desired_capacity" {
  description = "Desired capacity of the autoscaling group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the autoscaling group"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the autoscaling group"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of target group ARNs"
  type        = list(string)
}

variable "launch_template_id" {
  description = "ID of the launch template"
  type        = string
}

variable "launch_template_version" {
  description = "Version of the launch template"
  type        = string
}