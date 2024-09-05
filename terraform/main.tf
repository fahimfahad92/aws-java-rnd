terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {
	name = "us-east-1"
}






