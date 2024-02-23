################# variables.tf for codebuild   ############################
# S3 bucket ID variable

variable "s3_bucket_id" {
  description = "S3 bucket ID"
  type        = string
  default     = "healthcare-north-website-bucket-2024"
}

# Artifacts store type variable

variable "artifacts_store_type" {
  description = "Artifacts store type"
  type        = string
  default     = "CODEPIPELINE"
}