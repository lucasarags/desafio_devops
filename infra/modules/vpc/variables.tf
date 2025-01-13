variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "internet_gateway_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "az_names" {
  description = "Availability zone names"
  type        = list(string)
}

variable "public_subnet_name" {
  description = "Name of the public subnets"
  type        = string
}

variable "public_route_table_name" {
  description = "Name of the public route table"
  type        = string
}