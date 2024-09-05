resource "aws_s3_bucket" "test_bucket" {
  bucket = "fahim-test-bucket"

  tags = {
    Name        = "Test bucket"
  }
}

resource "aws_s3_bucket_cors_configuration" "bucket_cors" {
  bucket = aws_s3_bucket.test_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
	max_age_seconds = 3000
  }
}