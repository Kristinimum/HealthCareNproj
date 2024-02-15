resource "aws_cloudfront_origin_access_control" "OAC" {
  name                              = "nch_website_access_control"
  description                       = "S3 static website cloudfront policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}