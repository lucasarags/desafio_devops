locals {
  app_index_hash = filemd5("${path.module}/../app/index.html")
}

resource "aws_launch_template" "launch_template" {
  name          = var.launch_template_name
  image_id      = var.ami
  instance_type = var.instance_type

  network_interfaces {
    device_index    = 0
    security_groups = [var.security_group_id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.launch_template_ec2_name
    }
  }

  user_data = base64encode(
    file("${path.module}/../common/install-docker.sh") 
    + "\n# Index hash: ${local.app_index_hash}"
  )

  lifecycle {
    create_before_destroy = true
  }
}
