variable "sns_topic_name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "sns_subscription_protocol" {
  description = "The protocol to use for the SNS subscription"
  type        = string
}

variable "sns_subscription_endpoint" {
  description = "The endpoint to use for the SNS subscription"
  type        = string
}