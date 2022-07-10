provider "aws" {
    region = "eu-west-2"
    default_tags {
      tags = {
        Application = "static_website"
        Owner = "RubenTadeia"
      }
    }
}

resource "aws_instance" "ec2" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    count = module.variables.number_of_servers
    security_groups = [aws_security_group.web_traffic.name]
    user_data = file(module.variables.first_script)

    tags = {
        Name = "Web Server"
    }
}

variable "ingress" {
    type = list(number)
    default = [80,443]
}

variable "egress" {
    type = list(number)
    default = [80,443]
}

resource "aws_security_group" "web_traffic" {
    name = "Allow Web Traffic"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
            from_port = port.value
            to_port = port. value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

        dynamic "egress" {
        iterator = port
        for_each = var.egress
        content {
            from_port = port.value
            to_port = port. value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

# Modules
module "variables" {
    source = "./../variables"
}

# Creating the website's module
/*module "staticwebsite" {
    source = "./../staticwebsite"
}*/


# Commands to test
#terraform plan -var-file=./../variables/development.tfvars
#terraform plan -var-file=./../variables/staging.tfvars