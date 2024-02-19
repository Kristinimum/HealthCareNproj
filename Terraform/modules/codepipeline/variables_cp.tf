
variable "project_name" {
  description = "codebuild project name"
  type        = string
  default     = "Pod2_HCN_Pipeline"
}

variable "name_pod2" {
  description = "codebuild project name"
  type        = string
  default     = "HCN_Pod2"
}

variable "s3_bucket_id" {
  description = "s3_bucket_id"
  type        = string
  default     = "healthcare-north-website-bucket-2024"
}

variable "artifacts_store_type" {
  description = "Artifacts store type"
  type        = string
  default     = "S3"
}

variable "repo_name" {
  description = "repository"
  type        = string
  default     = "Pod2_HCN_Repo"
}

variable "source_provider" {
  description = "source_provider"
  type        = string
  default     = "GitHub"
}

variable "input_artifacts" {
  description = "input_artifacts"
  type        = string
  default     = "tf-code"
}

variable "output_artifacts" {
  description = "output_artifacts"
  type        = string
  default     = "tf-code"
}

variable "full_repository_id" {
  description = "full_repository_id"
  type        = string
  default     = ""
}

variable "branch_name" {
  description = "branch_name"
  type        = string
  default     = "main"
}

variable "codestar_connector_credentials" {
  description = "codestar_connector_credentials"
  type        = string
  default     = ""
  sensitive = true  # Consider marking sensitive variables
}

variable "output_artifact_format" {
  description = "OutputArtifactFormat"
  type        = string
  default     = "CODE_ZIP"
}

variable "role_name" {
  description = "role_name"
  type        = string
  default     = "Pod2_Pipeline"
}

variable "policy_name" {
  description = "policy_name"
  type        = string
  default     = "HCN_Policy"
}

variable "approve_sns_arn" {
  description = "SNS arn"
  type        = string
  default     = "sns"
}

variable "approve_comment" {
  description = "approval comment"
  type        = string
  default     = "Terraform code updated"
}

variable "approve_url" {
  description = "approval url"
  type        = string
  default     = "url"
}