resource "aws_sns_topic" "cloudwatch_alarms" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.cloudwatch_alarms.arn
  protocol  = var.sns_subscription_protocol
  endpoint  = var.sns_subscription_endpoint
}
