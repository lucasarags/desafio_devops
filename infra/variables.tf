variable "aws_profile" {
  type        = string
  description = "AWS profile name for authentication"
  # default     = "arags"
}

variable "aws_region" {
  type        = string
  description = "AWS region where resources will be deployed"
  # default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  # default     = "172.16.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "Name tag for the VPC"
  # default     = "rte-wk6-vnet"
}

variable "internet_gateway_name" {
  type        = string
  description = "Name tag for the internet gateway"
  # default     = "rte-wk6-internet-gateway"
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "CIDR blocks for the public subnets"
  # default     = ["172.16.0.0/24", "172.16.1.0/24"]
}

variable "az_names" {
  type        = list(string)
  description = "Availability zone names"
  # default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_name" {
  type        = string
  description = "Name tag for the public subnets"
  # default     = "rte-wk6-public-subnet"
}

variable "public_route_table_name" {
  type        = string
  description = "Name tag for the public route table"
  # default     = "rte-wk6-public-route-table"
}

variable "alb_security_group_name" {
  type        = string
  description = "Name tag for the ALB security group"
  # default     = "rte-wk6-alb-security-group"
}

variable "asg_security_group_name" {
  type        = string
  description = "Name tag for the ASG security group"
  # default     = "rte-wk6-asg-security-group"
}

variable "alb_name" {
  type        = string
  description = "Name for the application load balancer"
  # default     = "rte-wk6-external-alb"
}

variable "alb_internal" {
  type        = bool
  description = "Whether the ALB is internal (true) or external (false)"
  # default     = false
}

variable "alb_type" {
  type        = string
  description = "The type of load balancer (application, network, or gateway)"
  # default     = "application"
}

variable "target_group_name" {
  type        = string
  description = "Name for the target group"
  # default     = "rte-wk6-alb-target-group"
}

variable "target_group_port" {
  type        = number
  description = "Port for the target group"
  # default     = 80
}

variable "target_group_protocol" {
  type        = string
  description = "Protocol for the target group"
  # default     = "HTTP"
}

variable "health_check_path" {
  type        = string
  description = "Path for the health check"
  # default     = "/"
}

variable "health_check_matcher" {
  type        = string
  description = "Response matcher for the health check"
  # default     = "200"
}

variable "listener_port" {
  type        = number
  description = "Port for the listener"
  # default     = 80
}

variable "listener_protocol" {
  type        = string
  description = "Protocol for the listener"
  # default     = "HTTP"
}

variable "default_action_type" {
  type        = string
  description = "Type for the default action"
  # default     = "forward"
}

variable "desired_capacity" {
  type        = number
  description = "Desired capacity for the autoscaling group"
  # default     = 3
}

variable "max_size" {
  type        = number
  description = "Maximum size for the autoscaling group"
  # default     = 5
}

variable "min_size" {
  type        = number
  description = "Minimum size for the autoscaling group"
  # default     = 2
}

variable "ami" {
  type        = string
  description = "ID of the Amazon Machine Image (AMI) for the launch template"
  # default     = "ami-006dcf34c09e50022"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the launch template"
  # default     = "t2.micro"
}

variable "launch_template_name" {
  type        = string
  description = "Name for the launch template"
  # default     = "rte-wk6-launch-template"
}

variable "launch_template_ec2_name" {
  type        = string
  description = "Name tag for the EC2 instances launched from the launch template"
  # default     = "rte-wk6-asg"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for Terraform state"
  # default     = "runway-s3-bucket"
}

variable "dynamodb_table_name" {
  type        = string
  description = "Name of the dynamodb table for Terraform state"
  # default     = "tfstate-dynamodb"
}

variable "terraform_state_key" {
  type        = string
  description = "Path of terraform state file"
  # default     = "terraform/terraform.tfstate"
}

variable "logstash_servers_count" {
  description = "Número de servidores do Logstash"
  type        = number
  # default     = 3
}

variable "sns_topic_name" {
  description = "The name of the SNS topic"
  type        = string
  # default     = "cloudwatch-alarms-topic"  
}

variable "sns_subscription_protocol" {
  description = "The protocol to use for the SNS subscription"
  type        = string
  # default     = "email"  
}

variable "sns_subscription_endpoint" {
  description = "The endpoint to use for the SNS subscription"
  type        = string
  # default     = "lucas.arags@gmail.com"  
}

