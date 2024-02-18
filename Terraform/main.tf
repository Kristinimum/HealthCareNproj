terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
  backend "s3" {

    encrypt = true
    bucket  = "pod2-hcn-022024"
    key     = "backend/tfstate"
    dynamodb_table = "tfstate-lock-dynamo"
    region = "us-east-1"

  }
}

provider "aws" {
  region = "us-east-1"
}


##############      MODULES     ################

module "buckets_s3" {
  source = "./modules/s3"
}

module "cloudfront_dist" {
  source        = "./modules/cloudfront"
  bucketID      = module.buckets_s3.bucketID
  bucket_domain = module.buckets_s3.bucket_domain
}

module "codebuild" {
  source = ".modules/codebuild"
}


#############      OUTPUTS      ################

output "website_domain_name" {
  value = "http://${module.cloudfront_dist.cf_domain_name}"
}