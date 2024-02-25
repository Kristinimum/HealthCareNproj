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

  #assume_role {
  #role_arn = "arn:aws:iam::654654434704:role/CodePipelineServiceRole"
  #}
}

locals {
  tags = {
    Project     = var.project
    CreatedBy   = var.createdBy
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}

##############      MODULES     ################

module "codepipeline" {
  source = "./modules/codepipeline"
  #source             = "https://github.com/Kristinimum/HealthCareNproj/tree/main/Terraform/files"
  #project_name       = var.project_name
  #s3_bucket_id       = var.s3_bucket_id
  #full_repository_id = var.full_repository_id
}

module "buckets_s3" {
  source = "./modules/s3"
}

module "cloudfront_dist" {
  source        = "./modules/cloudfront"
  bucketID      = module.buckets_s3.bucketID
  bucket_domain = module.buckets_s3.bucket_domain
}

module "codebuild" {
  source = "./modules/codebuild"
}


#############      OUTPUTS      ################

output "website_domain_name" {
  value = "http://${module.cloudfront_dist.cf_domain_name}"
}