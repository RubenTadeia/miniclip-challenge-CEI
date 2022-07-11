## 
# Resources

## 
# Instances
resource "aws_instance" "web" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    security_groups = [module.sg.sg_name]
    user_data = file(var.first_script)

    tags = {
        Name = var.server_name
    }
}

module "eip" {
    source = "./../eip"
    instance_id = aws_instance.web.id
}

module "sg" {
    source = "./../sg"
}