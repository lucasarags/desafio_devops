resource "aws_autoscaling_group" "auto_scaling_group" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  service_linked_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
}

data "aws_caller_identity" "current" {}