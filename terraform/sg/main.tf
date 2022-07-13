##
# Resources

/*resource "aws_security_group" "web_traffic" {
  name = "Allow Web Traffic"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    dynamic "egress" {
    iterator = port
    for_each = var.egress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}*/

resource "aws_security_group" "autoscallinggroup_sg" {
  name = "Auto Scaling Group port 80 and 443"

  description = "Allow https autoscallinggroup"
   dynamic "ingress" {
    iterator = port
    for_each = var.ingress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["172.0.0.0/16"]
        }
    }
    dynamic "egress" {
    iterator = port
    for_each = var.egress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["172.0.0.0/16"]
        }
    }
}


resource "aws_security_group" "loadbalancer_sg" {
  name = "Load Balancer port 80 and 443"

  description = "Allow https load balancer"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    dynamic "egress" {
    iterator = port
    for_each = var.egress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

}