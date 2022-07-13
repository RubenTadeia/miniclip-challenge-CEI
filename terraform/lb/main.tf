## 
# Resources

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.lbvpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "Subnet-1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.lbvpc.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "Subnet-2"
  }
}

# Application Load Balancer
resource "aws_lb" "loadBalancer" {
  name               = var.loadbalancer_name
  internal           = true
  load_balancer_type = "application"
  security_groups    = [module.sg.lb_sg_id]
  
  subnets            = [aws_subnet.subnet-1.id,aws_subnet.subnet-2.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = module.staticwebsite.bucket_value
    prefix  = "lb-logs"
    enabled = true
  }

  tags = {
    Environment = var.environment_name
  }
}


# Instance Target Group
resource "aws_lb_target_group" "lbtargetgroup" {
  name        = var.loadbalancer_name
  target_type = "instance"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = aws_vpc.lbvpc.id
  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
  }
}

resource "aws_vpc" "lbvpc" {
  cidr_block = "10.10.0.0/16"
}

# Listener Load Balancer
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.loadBalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lbtargetgroup.arn
  }
}


# Modules
module "sg" {
    source = "./../sg"
}

# Creating the website's module
module "staticwebsite" {
    source = "./../staticwebsite"
    environment_name = var.environment_name
    bucket_name = var.bucket_name
    index_document_to_be_deployed = var.index_document_to_be_deployed
    error_file_to_be_deployed = var.error_file_to_be_deployed
}