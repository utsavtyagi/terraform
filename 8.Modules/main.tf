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
