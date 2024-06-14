# VPC

Amazon Virtual Private Cloud (VPC) is a service that lets you launch AWS resources in a logically isolated virtual network that you define.

## Creating a VPC Using the AWS Management Console

Follow these steps to create a Virtual Private Cloud (VPC) using the AWS Management Console:

### 1. Sign In to AWS Management Console
- Open the AWS Management Console at [https://aws.amazon.com/console/](https://aws.amazon.com/console/).
- Sign in with your AWS credentials.

### 2. Navigate to the VPC Dashboard
- In the AWS Management Console, type "VPC" in the search bar at the top.
- Select "VPC" from the dropdown list to open the VPC Dashboard.

### 3. Start VPC Creation
- In the VPC Dashboard, click on "Your VPCs" in the left-hand menu.
- Click the "Create VPC" button at the top.

### 4. Configure VPC Settings
- **Name tag:** Enter a name for your VPC. (e.g., `MyVPC`)
- **IPv4 CIDR block:** Enter an IPv4 CIDR block for your VPC. (e.g., `10.0.0.0/16`)
- **IPv6 CIDR block:** Optional. If you need IPv6, select "Amazon-provided IPv6 CIDR block".
- **Tenancy:** Choose "Default" unless you need dedicated hardware for compliance or licensing purposes.

### 5. Create the VPC
- Click the "Create VPC" button at the bottom to create the VPC with the specified settings.

### 6. Configure Subnets
- After the VPC is created, navigate to the "Subnets" section in the left-hand menu.
- Click "Create subnet".
- Select the VPC you just created from the dropdown list.
- **Subnet settings:**
  - **Name tag:** Enter a name for your subnet. (e.g., `MySubnet1`)
  - **Availability Zone:** Choose an availability zone. (e.g., `us-east-1a`)
  - **IPv4 CIDR block:** Enter an IPv4 CIDR block for the subnet. (e.g., `10.0.1.0/24`)
- Click "Create subnet".

### 7. Create an Internet Gateway
- Navigate to the "Internet Gateways" section in the left-hand menu.
- Click "Create internet gateway".
- **Name tag:** Enter a name for your internet gateway. (e.g., `MyInternetGateway`)
- Click "Create internet gateway".
- Select the internet gateway you just created, and click "Actions" -> "Attach to VPC".
- Select your VPC from the dropdown list and click "Attach internet gateway".

### 8. Update Route Tables
- Navigate to the "Route Tables" section in the left-hand menu.
- Select the route table associated with your VPC (usually the main route table).
- Click on the "Routes" tab, then click "Edit routes".
- Add a new route:
  - **Destination:** Enter `0.0.0.0/0` for all internet traffic.
  - **Target:** Select the internet gateway you created.
- Click "Save routes".

### 9. Configure Security Groups
- Navigate to the "Security Groups" section in the left-hand menu.
- Click "Create security group".
- **Name tag:** Enter a name for your security group. (e.g., `MySecurityGroup`)
- **Description:** Enter a description for your security group.
- **VPC:** Select the VPC you created.
- Click "Create security group".
- Select the security group you just created, and click on the "Inbound rules" tab, then click "Edit inbound rules".
- Add rules as needed to allow traffic (e.g., HTTP, HTTPS, SSH).

### 10. Launch Instances (Optional)
- You can now launch EC2 instances within your VPC. When launching an instance, make sure to select the VPC and subnet you created, and assign the security group you configured.

By following these steps, you’ll have successfully created a VPC in AWS, configured with subnets, an internet gateway, and a security group.

## Creating a VPC Using Terraform

### Create the VPC
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
  region = "us-west-2" # Set your desired AWS region
}

resource "aws_vpc" "vpc_demo" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_demo"
  }
}
```

### Configure Subnets
```hcl
resource "aws_subnet" "vpc_demo_public_subnet" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "vpc_demo_public_subnet"
  }
}

resource "aws_subnet" "vpc_demo_private_subnet" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "vpc_demo_private_subnet"
  }
}
```

### Create an Internet Gateway
```hcl
resource "aws_internet_gateway" "vpc_demo_internet_gateway" {
  vpc_id = aws_vpc.vpc_demo.id

  tags = {
    Name = "vpc_demo_internet_gateway"
  }
}
```

### Add and Update Route Tables
```hcl
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
```

### Configure Security Groups

```hcl
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

### Create an EC2 instance in this VPC and configurations

```

```