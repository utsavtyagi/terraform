terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-west-2" # Set your desired AWS region
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0b20a6f09484773af" # Specify an appropriate AMI ID
  instance_type = "t2.micro"
  key_name = "demo_config_key_us-west-2"
  vpc_security_group_ids = [ "sg-00f1906a3bb9a9383" ]
  subnet_id = "subnet-c6b4b7bf"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<html><body><h1>Hi Utsav! Welcome to your EC2 instance!</h1></body></html>" > /var/www/html/index.html
              EOF
  tags = {
    Name = "ExampleInstance"
  }
}
