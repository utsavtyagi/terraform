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
