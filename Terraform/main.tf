terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }

  backend "s3" {

    encrypt        = true
    bucket         = "pod2-hcn-022024"
    key            = "backend/tfstate"
    dynamodb_table = "tfstate-lock-dynamo"
    region         = "us-east-1"

  }
}

provider "aws" {
  region = "us-east-1"
}


