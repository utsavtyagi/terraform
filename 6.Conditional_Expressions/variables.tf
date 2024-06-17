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

variable "environment" {
  description = "The name to tag the instance with"
  type        = string
  default     = "Production"
}
