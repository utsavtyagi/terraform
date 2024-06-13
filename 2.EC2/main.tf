terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-west-2"  # Set your desired AWS region
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0b20a6f09484773af"  # Specify an appropriate AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}
