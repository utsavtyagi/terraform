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
```
### Creating an EC2 Instance Using Terraform
Steps to Apply the Terraform Configuration

1. **Save the Configuration**: Save the above code in a file named main.tf.
2. **Initialize Terraform**: Run the following command to initialize the Terraform working director
```powershell
   terraform init
```
3. **Plan the Changes**: Run the following command to preview the changes Terraform will make.
```powershell
   terraform plan
```
4. **Apply the Configuration**: Run the following command to apply the configuration and create the EC2 instance.
```powershell
   terraform apply
```
This will set up the AWS provider and create an EC2 instance as specified in the main.tf file.

## Creating an EC2 Instance Using Terraform including Key Name

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
  key_name = "demo_config_key_us-west-2"

  tags = {
    Name = "ExampleInstance"
  }
}
```

## Creating an EC2 Instance Using Terraform including Security Group

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
  key_name = "demo_config_key_us-west-2"
  vpc_security_group_ids = [ "sg-00f1906a3bb9a9383" ]

  tags = {
    Name = "ExampleInstance"
  }
}
```

## Creating an EC2 Instance Using Terraform including Subnet and user data

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
```

