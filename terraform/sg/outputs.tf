##
# Outputs

/*output "sg_name" {
  value = aws_security_group.web_traffic.name
}*/

output "asg_sg_id" {
  value = aws_security_group.autoscallinggroup_sg.id
}

output "lb_sg_id" {
  value = aws_security_group.loadbalancer_sg.id
}