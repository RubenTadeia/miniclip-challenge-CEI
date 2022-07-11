##
# Outputs

output "website_endpoint" {
    value = aws_s3_bucket.bucketwebsite.website_endpoint
}