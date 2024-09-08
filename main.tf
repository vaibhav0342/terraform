# main.tf

# Specify the AWS provider and configure with credentials
provider "aws" {
  region = "us-west-2"  # Specify your AWS region
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-example-bucket-terraform"  # Must be globally unique
  acl    = "private"                      # Access control list (ACL) setting

  # Enable versioning for the bucket
  versioning {
    enabled = true
  }

  # Tagging the bucket for better management
  tags = {
    Name        = "MyExampleBucket"
    Environment = "Dev"
  }
}

# Optional: Bucket policy for public read access (e.g., for a static website)
resource "aws_s3_bucket_policy" "example_policy" {
  bucket = aws_s3_bucket.example_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Principal = "*"
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.example_bucket.arn}/*"
      }
    ]
  })
}
