terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.42"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      System = local.system_name
      Env    = local.env_name
    }
  }
}