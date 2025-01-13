  resource "aws_lb" "alb" {
    name               = var.alb_name
    internal           = var.alb_internal
    load_balancer_type = var.alb_type
    security_groups    = [var.alb_security_group_id]
    subnets            = var.alb_subnets
  }

  resource "aws_lb_target_group" "target_group" {
    name     = var.target_group_name
    port     = var.target_group_port
    protocol = var.target_group_protocol
    vpc_id   = var.vpc_id

    health_check {
      path    = var.health_check_path
      matcher = var.health_check_matcher
    }
  }

  resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = var.listener_port
    protocol          = var.listener_protocol

    default_action {
      type             = var.default_action_type
      target_group_arn = aws_lb_target_group.target_group.arn
    }
  }