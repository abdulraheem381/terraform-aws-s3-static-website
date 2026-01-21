resource "random_id" "bucket_id" {

  byte_length = 8

}

# Create a bucket 

resource "aws_s3_bucket" "mywebapp" {

  bucket = "mywebapp-${random_id.bucket_id.hex}"

}

resource "aws_s3_bucket_public_access_block" "example" {

  bucket = aws_s3_bucket.mywebapp.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "index_html" {

  bucket       = aws_s3_bucket.mywebapp.bucket
  key          = "index.html"
  source       = "../website/index.html"
  content_type = "text/html"
  etag         = filemd5("../website/index.html")

}

resource "aws_s3_object" "styles_css" {

  bucket       = aws_s3_bucket.mywebapp.bucket
  key          = "styles.css"
  source       = "../website/styles.css"
  content_type = "text/css"
  etag         = filemd5("../website/styles.css")

}

resource "aws_s3_object" "script_js" {

  bucket       = aws_s3_bucket.mywebapp.bucket
  key          = "script.js"
  source       = "../website/script.js"
  content_type = "application/javascript"
  etag         = filemd5("../website/script.js")

}

resource "aws_s3_bucket_website_configuration" "webapp" {
  bucket = aws_s3_bucket.mywebapp.id

  index_document {

    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_outside" {

  bucket = aws_s3_bucket.mywebapp.id
  policy = jsonencode(

    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject"
          Resource  = "arn:aws:s3:::${aws_s3_bucket.mywebapp.id}/*"
        }
      ]
    }
  )

}

output "website_url" {

  value = aws_s3_bucket_website_configuration.webapp.website_endpoint

}
