// Images S3 Bucket
resource "aws_s3_bucket" "images_proof_oc" {
  bucket = var.images_bucket_name_proof_oc

  tags = {
    "Name"              = "Images Bucket Proof OC"
  }
  timeouts {
    create = "5m"    
  }
}

// Create a "Memes" dir in the images bucket
resource "aws_s3_object" "memes_folder" {
  bucket = aws_s3_bucket.images_proof_oc.bucket
  key    = "Memes/"
  source = "/dev/null"
}

// Images S3 Bucket LS Policy
resource "aws_s3_bucket_lifecycle_configuration" "images_lifecycle" {
  bucket = aws_s3_bucket.images_proof_oc.bucket

  rule {
    id     = "memes-90-days-to-glacier"
    status = "Enabled"

    filter {
      prefix = "Memes/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
    timeouts {
    create = "5m"
  }
}

// Logs S3 Bucket
resource "aws_s3_bucket" "log_proof_oc" {
  bucket = var.logs_bucket_name_proof_oc

  tags = {
    "Name"    = "Logs Bucket Proof OC"
  }
    timeouts {
    create = "5m"   
  }
}

// Create a "Active" dir in the logs bucket
resource "aws_s3_object" "active_folder" {
  bucket = aws_s3_bucket.log_proof_oc.bucket
  key    = "Active/"
  source = "/dev/null"
}

// Create a "Inactive" dir in the logs bucket
resource "aws_s3_object" "inactive_folder" {
  bucket = aws_s3_bucket.log_proof_oc.bucket
  key    = "Inactive/"
  source = "/dev/null"
}

// Logs 'Active" Dir S3 Bucket LS Policy
resource "aws_s3_bucket_lifecycle_configuration" "logs_lifecycle" {
  bucket = aws_s3_bucket.log_proof_oc.bucket

  rule {
    id     = "active-logs-90-days-to-glacier"
    status = "Enabled"

    filter {
      prefix = "Active/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }

  rule {
    id     = "delete-inactive-logs-90-days-old"
    status = "Enabled"

    filter {
      prefix = "Inactive/"
    }

    expiration {
      days = 90
    }
  }

  timeouts {
    create = "5m"
  }
}


