variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "region" {
  description = "Region for our DynamoDB and S3 buckets"
  type        = string
}


