terraform {
  required_version = "1.8.7"

  backend "s3" {
    region         = "ap-northeast-1"
    bucket         = "minamijoyo-digger-tfstate-aws"
    key            = "envs/ops/base/terraform.tfstate"
    dynamodb_table = "tflock"
    profile        = "minamijoyo-tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.1"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "minamijoyo-ops"
}

