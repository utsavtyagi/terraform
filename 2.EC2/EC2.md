# Creating an EC2 Instance

Amazon Elastic Compute Cloud (Amazon EC2) is a web service that provides secure, resizable compute capacity in the cloud.

## Creating an EC2 Instance Using AWS Management Console

To create an EC2 instance using the AWS Management Console, follow these steps:

1. **Log into AWS Management Console**: Go to the EC2 Dashboard.
2. **Launch Instance**: Click on "Launch Instance" and select an Amazon Machine Image (AMI).
3. **Choose Instance Type**: Select the desired instance type based on your requirements.
4. **Configure Instance**: Set instance details, such as network and IAM role, then add storage and tags.
5. **Review and Launch**: Review your configuration, create a new key pair or select an existing one, and then launch the instance.

## Creating an EC2 Instance Using Terraform

Here's a simplified Terraform configuration to create an EC2 instance:

```hcl
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
