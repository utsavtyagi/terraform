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

