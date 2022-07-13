##
# Outputs

output "website_endpoint" {
    value = aws_s3_bucket_website_configuration.bucketwebsite.website_endpoint
}

output "bucket_value" {
    value = aws_s3_bucket.buck.bucket
}