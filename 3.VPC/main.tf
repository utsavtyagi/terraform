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

resource "aws_subnet" "vpc_demo_public_subnet" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "vpc_demo_public_subnet"
  }
}

resource "aws_subnet" "vpc_demo_private_subnet" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "10.0.2.0/24"

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
