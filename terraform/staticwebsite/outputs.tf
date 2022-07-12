##
# Outputs

output "website_endpoint" {
    value = aws_s3_bucket_website_configuration.bucketwebsite.website_endpoint
}