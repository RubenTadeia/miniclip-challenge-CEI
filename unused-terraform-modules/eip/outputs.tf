## 
# Outputs

output "PublicIP" {
    value = aws_eip.web_ip.public_ip
}