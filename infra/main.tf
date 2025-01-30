module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                = var.vpc_cidr
  vpc_name                = var.vpc_name
  internet_gateway_name   = var.internet_gateway_name
  public_subnet_cidr      = var.public_subnet_cidr
  az_names                = var.az_names
  public_subnet_name      = var.public_subnet_name
  public_route_table_name = var.public_route_table_name
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id                  = module.vpc.vpc_id
  alb_security_group_name = var.alb_security_group_name
  asg_security_group_name = var.asg_security_group_name
}

module "load_balancer" {
  source = "./modules/load_balancer"

  alb_name              = var.alb_name
  alb_internal          = var.alb_internal
  alb_type              = var.alb_type
  alb_security_group_id = module.security_group.alb_security_group_id
  alb_subnets           = module.vpc.public_subnets
  target_group_name     = var.target_group_name
  target_group_port     = var.target_group_port
  target_group_protocol = var.target_group_protocol
  vpc_id                = module.vpc.vpc_id
  health_check_path     = var.health_check_path
  health_check_matcher  = var.health_check_matcher
  listener_port         = var.listener_port
  listener_protocol     = var.listener_protocol
  default_action_type   = var.default_action_type
}

module "autoscaling_group" {
  source = "./modules/autoscaling_group"

  desired_capacity        = var.desired_capacity
  max_size                = var.max_size
  min_size                = var.min_size
  subnet_ids              = module.vpc.public_subnets
  target_group_arns       = [module.load_balancer.target_group_arn]
  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_latest_version
}

module "launch_template" {
  source = "./modules/launch_template"

  launch_template_name     = var.launch_template_name
  ami                      = var.ami
  instance_type            = var.instance_type
  security_group_id        = module.security_group.asg_security_group_id
  launch_template_ec2_name = var.launch_template_ec2_name
}

module "sns" {
  source = "./modules/sns"

  sns_topic_name            = var.sns_topic_name
  sns_subscription_protocol = var.sns_subscription_protocol
  sns_subscription_endpoint = var.sns_subscription_endpoint
}


resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "main-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "text",
        properties = {
          markdown = "## ALB Metrics"
        }
      },
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", module.load_balancer.alb_arn_suffix]
          ],
          period = 300,
          stat   = "Sum",
          region = var.aws_region,
          title  = "Request Count",
          view   = "timeSeries"
        }
      },
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", module.load_balancer.alb_arn_suffix]
          ],
          period = 300,
          stat   = "Average",
          region = var.aws_region,
          title  = "Target Response Time",
          view   = "timeSeries"
        }
      },
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "UnhealthyHostCount", "LoadBalancer", module.load_balancer.alb_arn_suffix]
          ],
          period = 300,
          stat   = "Average",
          region = var.aws_region,
          title  = "Unhealthy Host Count",
          view   = "bar"
        }
      },
      {
        type = "text",
        properties = {
          markdown = "## EC2 Metrics"
        }
      },
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", module.autoscaling_group.auto_scaling_group_name]
          ],
          period = 300,
          stat   = "Average",
          region = var.aws_region,
          title  = "ASG CPU Utilization",
          view   = "timeSeries"
        }
      },
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/EC2", "NetworkIn", "AutoScalingGroupName", module.autoscaling_group.auto_scaling_group_name]
          ],
          period = 300,
          stat   = "Sum",
          region = var.aws_region,
          title  = "ASG Network In",
          view   = "timeSeries"
        }
      },
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/EC2", "NetworkOut", "AutoScalingGroupName", module.autoscaling_group.auto_scaling_group_name]
          ],
          period = 300,
          stat   = "Sum",
          region = var.aws_region,
          title  = "ASG Network Out",
          view   = "timeSeries"
        }
      },
      {
        type = "text",
        properties = {
          markdown = "## Auto Scaling Group Metrics"
        }
      }
    ]
  })
}

resource "aws_cloudwatch_metric_alarm" "alb_healthyhosts" {
  alarm_name          = "alarmname"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = var.logstash_servers_count
  alarm_description   = "Number of healthy nodes in Target Group"
  actions_enabled     = true
  alarm_actions       = [module.sns.sns_topic_arn]
  ok_actions          = [module.sns.sns_topic_arn]
  dimensions = {
    LoadBalancer = module.load_balancer.alb_arn_suffix
  }
}

