output "id_vpc" {
  description = "ID da VPC criada"
  value       = aws_vpc.devops_vpc.id
}

output "subnet_pub_1a" {
  value = aws_subnet.devops_public_subnet_1a.id
}

output "subnet_pub_1b" {
  value = aws_subnet.devops_public_subnet_1b.id
}

output "subnet_priv_1a" {
  value = aws_subnet.devops_private_subnet_1a.id
}

output "subnet_priv_1b" {
  value = aws_subnet.devops_private_subnet_1b.id
}

output "subnet_ec2" {
  value = aws_subnet.devops_public_subnet_ec2.id
}
