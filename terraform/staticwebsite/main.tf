##
# Resources

# Creating the S3 Bucket

resource "aws_s3_bucket_acl" "bucket" {
    bucket = var.bucket_name
    acl = "private"
}

resource "aws_s3_bucket_website_configuration" "bucketwebsite" {
    bucket = var.bucket_name
    
    // In older version of aws_s3_bucket
    //acl = "public-read"
    //policy = data.aws_iam_policy_document.website_policy.json

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