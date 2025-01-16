output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "alb_name" {
  description = "Name of the Application Load Balancer"
  value       = aws_lb.alb.name
}

output "alb_arn_suffix" {
  description = "Parte específica do ARN do Application Load Balancer que você precisa acessar"
  value        = join("/", slice(split("/", aws_lb.alb.arn), 1, length(split("/", aws_lb.alb.arn))))
}

