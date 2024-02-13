resource "aws_s3_bucket" "website_bucket" {
  bucket = "north-health-care-website"

  tags = {
    Name = "WebsiteBucket"
  }
}
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.id
  key    = "index.html"
  source = "./www/index.html"  # Path to index.html relative to the root directory
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.id
  key    = "error.html"
  source = "./www/error.html"  # Path to error.html relative to the root directory
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block"{
    bucket = aws_s3_bucket.website_bucket.id

    block_public_acls = false
    block_public_policy = false
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

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.website_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "null_resource" "delay" {
  depends_on = [aws_s3_bucket.website_bucket]

  provisioner "local-exec" {
    command = "sleep 30" # Wait for 30 seconds, adjust the duration as needed
  }
}

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = [
          "s3:GetObject",
          "s3:PutObject",   # Adding s3:PutObject action to allow uploading objects
          "s3:PutBucketPolicy"
        ],
        Resource  = [
          aws_s3_bucket.website_bucket.arn,
          "${aws_s3_bucket.website_bucket.arn}/*"
        ]
      }
    ]
  })
  depends_on = [null_resource.delay]
}
