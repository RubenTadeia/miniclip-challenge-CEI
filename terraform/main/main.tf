## 
# Provider
provider "aws" {
    region = "eu-west-2"
    default_tags {
      tags = {
        Application = "static_website"
        Owner = "RubenTadeia"
      }
    }
}


##
# Modules
# Web part module
module "web" {
    source = "./../web"
    server_name = var.server_name
    first_script = var.first_script
}

# Creating the website's module
module "staticwebsite" {
    source = "./../staticwebsite"
    bucket_name = var.bucket_name
    index_document_to_be_deployed = var.index_document_to_be_deployed
}


output "PublicIP" {
    value = module.web.pub_ip
}

# Commands to test
#terraform plan -var-file=./../envvars/development.tfvars
#terraform plan -var-file=./../envvars/staging.tfvars