output "id_vpc" {
  description = "ID da VPC criada"
  value       = module.devops_network.id_vpc
}

output "subnet_pub_1a" {
  value = module.devops_network.subnet_pub_1a
}

output "subnet_pub_1b" {
  value = module.devops_network.subnet_pub_1b
}

output "subnet_priv_1a" {
  value = module.devops_network.subnet_priv_1a
}

output "subnet_priv_1b" {
  value = module.devops_network.subnet_priv_1b
}

output "cluster_name" {
  value = module.devops_eks_cluster.cluster_name
}