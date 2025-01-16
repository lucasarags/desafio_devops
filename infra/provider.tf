terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }

  backend "s3" {
    bucket         = "runway-s3-bucket"
    key            = "terraform-project"
    region         = "us-east-1"
    dynamodb_table = "tfstate-dynamodb"
    profile        = "arags"
  }
}

provider "aws" {
  profile = arags
  region  = us-east-1
}