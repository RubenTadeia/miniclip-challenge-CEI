##
# Resources
# Creating the S3 Bucket
resource "aws_s3_bucket" "bucketwebsite" {
    bucket = bucket_name
    acl = "public-read"
    //policy = file(policy.json)
    policy = data.aws_iam_policy_document.website_policy.json

    website {
      index_document = var.index_document_to_be_deployed
      error_document = "error.html"
      tags = {
        terraform = "true"
        website_hosting = "true"
      }
    }
}

# Now lets upload the files to the bucket
resource "aws_s3_bucket_object" "index_object" {
  bucket = var.bucket_name
  key = "index.html"
  source = var.index_document_to_be_deployed
}

resource "aws_s3_bucket_object" "error_object" {
  bucket = var.bucket_name
  key = "error.html"
  source = "./../staticwebsite/html/error.html" 
}