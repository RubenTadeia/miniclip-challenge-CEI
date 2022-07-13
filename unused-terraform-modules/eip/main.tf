## 
# Resources

resource "aws_eip" "web_ip" {
    instance = var.instance_id
}
