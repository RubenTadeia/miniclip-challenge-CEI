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

# This module became deprecated after using Auto Scaling Groups
# Web part module
/*module "web" {
    source = "./../web"
    server_name = var.server_name
    first_script = var.first_script
    ami_name = var.ami_name
}*/

# Creating autoscaling module
module "autoscaling" {
    source = "./../autoscaling"
    first_script = var.first_script
    ami_name = var.ami_name
    server_name = var.server_name
    auto_scaling_group_name = var.auto_scaling_group_name
    auto_scaling_group_min_inst = var.auto_scaling_group_min_inst
    auto_scaling_group_max_inst = var.auto_scaling_group_max_inst
    availability_zone = var.availability_zone
}

# Creating loadbalancer's module
module "loadbalancer" {
    source = "./../lb"
    loadbalancer_name = var.loadbalancer_name
    environment_name = var.environment_name
    bucket_name = var.bucket_name
    index_document_to_be_deployed = var.index_document_to_be_deployed
    error_file_to_be_deployed = var.error_file_to_be_deployed
}

# Commands to test
#terraform plan -var-file=./../envvars/development.tfvars
#terraform plan -var-file=./../envvars/staging.tfvars