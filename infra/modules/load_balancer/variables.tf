variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "alb_internal" {
  description = "Boolean flag indicating whether the ALB is internal or external"
  type        = bool
}

variable "alb_type" {
  description = "Type of the load balancer"
  type        = string
}

variable "alb_security_group_id" {
  description = "ID of the security group associated with the ALB"
  type        = string
}

variable "alb_subnets" {
  description = "List of subnet IDs in which the ALB will be deployed"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port on which the target group is listening"
  type        = number
}

variable "target_group_protocol" {
  description = "Protocol of the target group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "health_check_path" {
  description = "Path for the health check"
  type        = string
}

variable "health_check_matcher" {
  description = "Status code for successful health checks"
  type        = string
}

variable "listener_port" {
  description = "Port on which the ALB listener is listening"
  type        = string
}

variable "listener_protocol" {
  description = "Protocol of the ALB listener"
  type        = string
}

variable "default_action_type" {
  description = "Type of the default action for the ALB listener"
  type        = string
}