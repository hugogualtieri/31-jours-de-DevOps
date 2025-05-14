terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "terraform-exercices-03"
    key            = "envs/prod/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform-exercices-03-lock-table"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
