provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Criação do S3 Bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.s3_bucket_name
  acl           = "private"
  force_destroy = true # Destroi o bucket e todo o conteúdo, use com cuidado

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "rule1"
    enabled = true
    prefix  = "rule1/"

    expiration {
      days = 90
    }
  }

  lifecycle_rule {
    id      = "rule2"
    enabled = true
    prefix  = "rule2/"

    expiration {
      days = 90
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "TerraformStateBucket"
    Environment = "dev"
  }
}

# Criação da tabela DynamoDB
resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformStateLockTable"
    Environment = "dev"
  }
}

# Criação da política de acesso ao S3 Bucket
resource "aws_iam_policy" "s3_access_policy" {
  name        = "terraform_s3_access_policy"
  description = "Policy for Terraform to access the S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })
}
