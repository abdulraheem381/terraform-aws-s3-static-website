terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "rand-id" {
  byte_length = 8
}

resource "aws_s3_bucket" "web-bucket" {
  bucket = "myweb-${random_id.rand-id.hex}"
}

resource "aws_s3_object" "index-html" {
  bucket       = aws_s3_bucket.web-bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles-css" {
  bucket       = aws_s3_bucket.web-bucket.bucket
  source       = "./styles.css"
  key          = "styles.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_public_access_block" "public-access" {
  bucket = aws_s3_bucket.web-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp" {
  bucket = aws_s3_bucket.web-bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.web-bucket.id}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.web-bucket.id

  index_document {
    suffix = "index.html"
  }
}

output "aws_s3_bucket_website_configuration" {
  value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}
