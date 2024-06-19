# Modules

Terraform modules are a way to organize and reuse configurations. They allow you to group related resources and their configurations into a single unit, which can then be used multiple times throughout your infrastructure code. Using modules helps to manage complexity and improve maintainability by encapsulating commonly used patterns and configurations. Here's an overview of how modules work and how to use them effectively in Terraform:

### Key Concepts of Terraform Modules
**Root Module:** This is the top-level module in a Terraform configuration. It consists of the main .tf files in the directory where you run Terraform commands. The root module can call child modules.

**Child Module:** A module that is called by another module. It can be defined in a separate directory or as a published module in the Terraform Registry.

**Module Source:** The location of a module, which can be a local path, a versioned module in the Terraform Registry, a Git repository, or other supported locations.

[Module Source](https://developer.hashicorp.com/terraform/language/modules/sources)

**Module Input Variables:** Variables defined in the module to accept values from the calling module. These are similar to input parameters for a function.

**Module Output Values:** Values that a module outputs back to the calling module. These allow data to be passed out of the module.

### Advantages of Using Modules

**Organization:** Encapsulate related resources and configurations.

**Reusability:** Write a module once and reuse it across different projects.

**Maintainability and Versioning:** Easier to manage and update infrastructure code. Modules can have their own versioning, making it easier to manage updates and changes.

**Collaboration:** Share modules with your team or the community. Modules make it easier for teams to collaborate on infrastructure projects. Different team members can work on separate modules independently, and then these modules can be combined to build complex infrastructure deployments. It can streamline development and reduce conflicts in the codebase.

**Testing and Validation:** Modules can be individually tested and validated, ensuring that they work correctly before being used in multiple projects. This reduces the risk of errors propagating across your infrastructure.


## Example: Using a Module

Here’s an example of how to create and use a Terraform module:

### Step 1: Create a Module
Create a directory for your module, e.g., my-vpc-module, and add the following files:

**main.tf**
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
  region = var.aws_region
}

resource "aws_vpc" "vpc_demo" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "vpc_demo_public_subnet" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = var.vpc_public_subnet_cidr_block
  availability_zone = var.vpc_public_subnet_avaialability_zone

  tags = {
    Name = "vpc_demo_public_subnet"
  }
}

resource "aws_subnet" "vpc_demo_private_subnet" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = var.vpc_private_subnet_cidr_block
  availability_zone = var.vpc_private_subnet_avaialability_zone
  tags = {
    Name = "vpc_demo_private_subnet"
  }
}

resource "aws_internet_gateway" "vpc_demo_internet_gateway" {
  vpc_id = aws_vpc.vpc_demo.id

  tags = {
    Name = "vpc_demo_internet_gateway"
  }
}

resource "aws_default_route_table" "vpc_demo_default_route_table" {
  default_route_table_id = aws_vpc.vpc_demo.default_route_table_id

  tags = {
    Name = "vpc_demo_default_route_table"
  }
}

resource "aws_route_table" "vpc_demo_public_route_table" {
  vpc_id = aws_vpc.vpc_demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_demo_internet_gateway.id
  }
  tags = {
    Name = "vpc_demo_public_route_table"
  }
}

resource "aws_route_table_association" "vpc_demo_default_route_table_association" {
  subnet_id      = aws_subnet.vpc_demo_private_subnet.id
  route_table_id = aws_default_route_table.vpc_demo_default_route_table.id
}

resource "aws_route_table_association" "vpc_demo_public_route_table_association" {
  subnet_id      = aws_subnet.vpc_demo_public_subnet.id
  route_table_id = aws_route_table.vpc_demo_public_route_table.id
}

resource "aws_security_group" "vpc_demo_security_group" {
  name        = "vpc_demo_security_group"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_demo.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc_demo_security_group"
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

variable "vpc_cidr_block" {
  description = "The cidr_block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "vpc_demo"
}

variable "vpc_public_subnet_cidr_block" {
  description = "The vpc_public_subnet_cidr_block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vpc_public_subnet_avaialability_zone" {
  description = "The vpc_public_subnet_avaialability_zone"
  type        = string
  default     = "us-west-2a"
}

variable "vpc_private_subnet_cidr_block" {
  description = "The vpc_private_subnet_cidr_block"
  type        = string
  default     = "10.0.2.0/24"
}

variable "vpc_private_subnet_avaialability_zone" {
  description = "The vpc_private_subnet_avaialability_zone"
  type        = string
  default     = "us-west-2b"
}
```

**outputs.tf**
```hcl
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc_demo.id
}

output "subnet_id_public" {
  description = "The ID of public subnet"
  value       = aws_subnet.vpc_demo_public_subnet.id
}

output "subnet_id_private" {
  description = "The ID of private subnet"
  value       = aws_subnet.vpc_demo_private_subnet.id
}

output "security_group_id" {
  description = "The aws_security_group"
  value       = aws_security_group.vpc_demo_security_group.id
}
```
### Step 2: Use the Module in a Root Module
In your root module directory, create the following configuration:

**main.tf:**
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
  region = "us-east-1"
}

module "my-vpc-module" {
  source              = "./my-vpc-module"
  #source               = "git::https://github.com/utsavtyagi/my-vpc-module.git"
  aws_region              =  "us-west-2"
  vpc_cidr_block          = "10.0.0.0/16"
  vpc_name                = "vpc_demo"
  vpc_public_subnet_cidr_block        = "10.0.11.0/24"
  vpc_public_subnet_avaialability_zone = "us-west-2a"
  vpc_private_subnet_cidr_block = "10.0.22.0/24"
  vpc_private_subnet_avaialability_zone = "us-west-2b"
}

output "vpc_id" {
  value = module.my-vpc-module.vpc_id
}

output "subnet_id_public" {
  value = module.my-vpc-module.subnet_id_public
}

output "security_group_id" {
  value = module.my-vpc-module.security_group_id
}
```

#### Module Sources
Modules can be sourced from various locations:

Local Path: source = "./my-vpc-module"

Git Repository: source = "git::https://github.com/utsavtyagi/my-vpc-module.git"

Other Supported Sources: Such as Terraform Registry, HTTP URLs, Mercurial, Bitbucket, GCS, S3, etc.