terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "terraform-statefile-demo"
    key = "StateFile_DEV/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true    
    dynamodb_table = "terraform-lock-table" #Optional
  }
}
provider "aws" {
  region = var.aws_region
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [ var.security_group_id ]
  subnet_id              = var.subnet_id
  user_data              = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "<html><body><h1>Hi Utsav! Welcome to your EC2 instance!</h1></body></html>" > /var/www/html/index.html
                EOF
  tags = {
    Name = var.instance_name
  }
}
