terraform {
  backend "s3" {
    bucket         = "runway-s3-bucket"
    key            = "terraform-project-iam"
    region         = "us-east-1"
    dynamodb_table = "tfstate-dynamodb"
    profile        = "arags"
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

# Criação da política IAM diretamente
resource "aws_iam_policy" "cloudwatch_access_policy" {
  name        = "cloudwatch_access_policy"
  description = "Policy to allow access to CloudWatch and related resources"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:DescribeAlarms",
          "ec2:DescribeInstances",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeTargetGroups",
          "autoscaling:DescribeAutoScalingGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# Criação do role IAM
resource "aws_iam_role" "cloudwatch_role" {
  name               = "CloudWatchRole"
  path               = "/codeway/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Associação da política ao role
resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attachment" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = aws_iam_policy.cloudwatch_access_policy.arn
}