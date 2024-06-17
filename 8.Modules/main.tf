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


module "my-vec2-module" {
  source              = "./my-ec2-module"
  #source               = "git::https://github.com/utsavtyagi/my-ec2-module.git"
  aws_region              =  "us-west-2"
  ami_id = "ami-0b20a6f09484773af"
  instance_type = "t2.micro"
  key_name = "demo_config_key_us-west-2"
  security_group_id =  module.my-vpc-module.security_group_id
  subnet_id = module.my-vpc-module.subnet_id_public
  instance_name = "ExampleInstance"
  
}
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.my-vec2-module.instance_id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = module.my-vec2-module.instance_public_ip
}