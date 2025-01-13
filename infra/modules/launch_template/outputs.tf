output "launch_template_id" {
  value = aws_launch_template.launch_template.id
}

output "launch_template_latest_version" {
  value = aws_launch_template.launch_template.latest_version
}

output "user_data_path" {
  value = "${path.module}/../common/install-apache.sh"
}
