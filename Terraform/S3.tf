resource "aws_s3_bucket" "website_bucket" {
  bucket = "north-health-care-website"
  force_destroy = true

  tags = {
    Name = "WebsiteBucket"
  }
}

resource "aws_s3_object" "upload_object" {
  for_each      = fileset("www/", "*")
  bucket        = aws_s3_bucket.website_bucket.id
  key           = each.value
  source        = "www/${each.value}"
  etag          = filemd5("www/${each.value}")
  content_type  = "text.html"
}


resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block"{
    bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "website_acl" {
  bucket = aws_s3_bucket.website_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Resource": ["${aws_s3_bucket.website_bucket.arn}/*"],
        "Action": "s3:PutObject",
        "Principal": "*",
        }
    ]
  })
} 