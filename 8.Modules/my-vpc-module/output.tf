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

