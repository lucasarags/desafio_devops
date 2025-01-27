resource "aws_autoscaling_group" "auto_scaling_group" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns
  force_new = true

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  service_linked_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"

    lifecycle {
    create_before_destroy = true
  }
}

data "aws_caller_identity" "current" {}