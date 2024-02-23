##################   Create s3 bucket to host static website    #################

resource "aws_s3_bucket" "website_bucket" {
  count         = length(var.bucket_names)
  bucket        = var.bucket_names[count.index]
  force_destroy = true

  tags = {
    Name = "WebsiteBucket"
  }
}


####  upload "index" & "error" html" files to the bucket from a local path  #####

resource "aws_s3_object" "upload_object" {
  for_each     = fileset("files/", "*")
  bucket       = aws_s3_bucket.website_bucket[1].id
  key          = each.value
  source       = "files/${each.value}"
  etag         = filemd5("files/${each.value}")
  content_type = "text/html"
}


###################     Remove blocks to public access    ######################

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  bucket = aws_s3_bucket.website_bucket[1].id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#############     Configure the s3 bucket to host static website    ###########

resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.website_bucket[1].id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

###  Bucket policy to allow AWS Cloudfront service to GetObject from bucket ###

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket[1].id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Resource" : ["${aws_s3_bucket.website_bucket[1].arn}/*"],
        "Action" : "s3:GetObject",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
      }
    ]
  })
} 