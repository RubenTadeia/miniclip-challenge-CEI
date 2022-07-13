##
# Resources

# Creating the S3 Bucket

resource "aws_s3_bucket" "buck" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment_name
  }
}

resource "aws_s3_bucket_acl" "bucket" {
    bucket = aws_s3_bucket.buck.id
    acl = "private"
}

resource "aws_s3_bucket_website_configuration" "bucketwebsite" {
    bucket = var.bucket_name

    index_document {
    suffix = "index.html"
    }

    error_document {
      key = "error.html"
    }

    routing_rule {
      condition {
        key_prefix_equals = "docs/"
      }
      redirect {
        replace_key_prefix_with = "documents/"
      }
    }
    depends_on = [aws_s3_bucket.buck]
}

# Now lets upload the files to the bucket
resource "aws_s3_object" "index_object" {
  bucket = var.bucket_name
  key = "index.html"
  source = var.index_document_to_be_deployed
  server_side_encryption = "AES256"
  depends_on = [aws_s3_bucket_website_configuration.bucketwebsite]
}

resource "aws_s3_object" "error_object" {
  bucket = var.bucket_name
  key = "error.html"
  source = var.error_file_to_be_deployed 
  server_side_encryption = "AES256"
  depends_on = [aws_s3_bucket_website_configuration.bucketwebsite]
}

##
# Data

data "aws_iam_policy_document" "website_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}