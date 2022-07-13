## 
# Resources

## 
# Instances
resource "aws_instance" "web" {
    ami = var.ami_name
    instance_type = "t2.micro"
    security_groups = [module.sg.sg_name]
    user_data = file(var.first_script)

    tags = {
        Name = var.server_name
    }
}

# This module  became deprecated after using Auto Scaling Groups
module "eip" {
    source = "./../eip"
    instance_id = aws_instance.web.id
}

module "sg" {
    source = "./../sg"
}