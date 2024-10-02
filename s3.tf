// Images S3 Bucket
resource "aws_s3_bucket" "images" {
  bucket = "images"

  tags = {
    "Project" = var.project_name
    "Name"    = "Images Bucket Proof OC"
  }
}


// Images S3 Bucket LS Policy
resource "aws_s3_bucket_lifecycle_configuration" "images_lifecycle" {
  bucket = aws_s3_bucket.images.bucket

  rule {
    id     = "Move Memes older than 90 days to Glacier"
    status = "Enabled"

    filter {
      prefix = "Memes/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}

// Logs S3 Bucket
resource "aws_s3_bucket" "logs" {
  bucket = "logs"

  tags = {
    "Project" = var.project_name
    "Name"    = "Logs Bucket Proof OC"
  }
}

// Logs 'Active" Dir S3 Bucket LS Policy
resource "aws_s3_bucket_lifecycle_configuration" "logs_active_lifecycle" {
  bucket = aws_s3_bucket.logs.bucket

  rule {
    id     = "Move Active logs older than 90 days to Glacier"
    status = "Enabled"

    filter {
      prefix = "Active/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}

// Logs "Inactive" Dir S3 Bucket LS Policy
resource "aws_s3_bucket_lifecycle_configuration" "logs_inactive_lifecycle" {
  bucket = aws_s3_bucket.logs.bucket

  rule {
    id     = "Delete Inactive logs older than 90 days"
    status = "Enabled"

    filter {
      prefix = "Inactive/"
    }

    expiration {
      days = 90
    }
  }
}

