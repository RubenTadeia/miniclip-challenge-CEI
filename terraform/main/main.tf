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
# Instances
resource "aws_instance" "ec2" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    count = var.number_of_servers
    security_groups = [module.sg.sg_name]
    user_data = file(var.first_script)

    tags = {
        Name = var.server_name
    }
}

##
# Modules
# Creating the security group's module
module "sg" {
    source = "./../sg"
}

# Creating the website's module
module "staticwebsite" {
    source = "./../staticwebsite"
    bucket_name = var.bucket_name
    index_document_to_be_deployed = var.index_document_to_be_deployed
}


# Commands to test
#terraform plan -var-file=./../envvars/development.tfvars
#terraform plan -var-file=./../envvars/staging.tfvars