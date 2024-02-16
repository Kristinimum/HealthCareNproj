variable "oac_name" {
  type    = string
  default = "nch_website_access_control"
}

variable "cloudfront_location_restrictions" {
  default = ["US", "CA"]
}

variable "bucketID" {}

variable "bucket_domain" {}
