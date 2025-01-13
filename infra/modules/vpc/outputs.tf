output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public_subnet[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gateway.id
}