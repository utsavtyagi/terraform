# Remote Backend for terraform state file

A remote backend is a type of Terraform backend that stores the state file in a remote location, such as a cloud object storage service or a database. Remote backends provide several benefits, such as enabling collaboration between team members, versioning state files, and providing a history of changes.

Terraform state files are crucial as they track the state of your infrastructure. Storing the state file remotely ensures collaboration, consistency, and backup. 

The local backend does not provide a way to easily share the state across different team members or systems. A remote backend, such as Amazon S3, Azure Storage, or HashiCorp Consul, is more suitable for collaboration. 

A remote backend stores the Terraform state file outside of your local file system and version control. Using S3 as a remote backend is a popular choice due to its reliability and scalability. Here's how to set it up:

#### Step 1: Create an S3 bucket in your AWS account to store the Terraform state. Ensure that the appropriate IAM permissions are set up.
1. Log in to AWS Management Console: Navigate to the S3 service.
2. Create a Bucket:
    - Click "Create bucket".
    - Provide a unique bucket name.
    - Select the AWS region where you want to create the bucket.
    - Configure the remaining settings as needed (versioning, encryption, etc.).
    - Click "Create bucket".

#### Step 2: Set Up DynamoDB Table for State Locking (Optional but Recommended)
1. Log in to AWS Management Console: Navigate to the DynamoDB service.
2. Create a Table:
    - Click "Create table".
    - Provide a table name (e.g., terraform-lock-table).
    - Set the partition key to LockID of type String.
    - Click "Create".

#### Step 3: Configure Terraform Backend
Create or update your main.tf file to use the S3 backend:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "terraform-statefile-demo"
    key = "StateFile/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true    
    dynamodb_table = "terraform-lock-table" #Optional
  }
}
```

#### Step 4: Initialize Terraform
Run terraform init: Initialize your Terraform configuration. This will configure the backend and, if needed, migrate your state file.

```powershell
terraform init
```
Terraform will detect the backend configuration and prompt you to migrate your state file if it already exists.

#### Step 5: Verify Configuration
Run terraform plan and terraform apply: Ensure that everything is configured correctly by running these commands to see if Terraform can read and write to the S3 bucket.
```powershell
terraform plan
terraform apply
```

### Example Terraform Configuration File (main.tf)
Here’s a complete example of with S3 backend configuration:

**main.tf**
```hcl
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
```

**variables.tf**
```hcl
variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-west-2"
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0b20a6f09484773af" # Specify your desired AMI ID
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use"
  type        = string
  default     = "demo_config_key_us-west-2"
}

variable "security_group_id" {
  description = "The ID of the security group to assign to the instance"
  type        = string
  default     = "sg-00f1906a3bb9a9383"
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in"
  type        = string
  default     = "subnet-c6b4b7bf"
}

variable "instance_name" {
  description = "The name to tag the instance with"
  type        = string
  default     = "ExampleInstance"
}

```

**output.tf**
```hcl
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}
```


### Security Considerations
**Enable Versioning:** Enable versioning on your S3 bucket to keep track of changes to your state file.

**Enable Server-Side Encryption:** Ensure server-side encryption is enabled for your bucket.

**Set up Bucket Policies and ACLs:** Restrict access to the bucket to only those who need it.
