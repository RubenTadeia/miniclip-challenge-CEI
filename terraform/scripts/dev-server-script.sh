#!/bin/bash
sudo yum update
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Hello I'm Ruben and this is the First Page of the DEVELOPMENT Environment</h1>" | sudo tee /var/www/html/index.html