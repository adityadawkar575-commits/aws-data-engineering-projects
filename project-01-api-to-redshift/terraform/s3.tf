resource "aws_s3_bucket" "data_bucket" {

  bucket = "${var.project_name}-bucket"

  tags = {
    Project = var.project_name
  }
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.data_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access" {

  bucket = aws_s3_bucket.data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
