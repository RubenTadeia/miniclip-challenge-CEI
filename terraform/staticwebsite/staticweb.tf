# Creating the S3 Bucket
resource "aws_s3_bucket" "bucketwebsite" {
    bucket = module.variables.var.bucket_name
    acl = "public-read"
    //policy = file(policy.json)
    policy = data.aws_iam_policy_document.website_policy.json

    website {
      index_document = module.variables.var.index_document_to_be_deployed
      error_document = "error.html"
      tags = {
        terraform = "true"
        website_hosting = "true"
      }
    }
}

# Now lets upload the files to the bucket
resource "aws_s3_bucket_object" "index_object" {
  bucket = module.variables.var.bucket_name
  key = "index.html"
  source = module.variables.var.index_document_to_be_deployed 
}

resource "aws_s3_bucket_object" "error_object" {
  bucket = module.variables.var.bucket_name
  key = "error.html"
  source = "./../staticwebsite/html/error.html" 
}
