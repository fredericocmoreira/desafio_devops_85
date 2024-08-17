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

module "devops_network" {
  source     = "./modules/network"
  bloco_cidr = var.bloco_cidr
  tags       = local.tags
}

module "devops_eks_cluster" {
  source           = "./modules/eks_cluster"
  tags             = local.tags
  public_subnet_1a = module.devops_network.subnet_pub_1a
  public_subnet_1b = module.devops_network.subnet_pub_1b
  rds_secret_name  = module.devops_secret_rds.rds_secret_name
  rds_endpoint     = module.devops_secret_rds.rds_endpoint
  name_db_rds      = var.name_db_rds
}

module "devops_cluster_node_group" {
  source            = "./modules/cluster-node-group"
  cluster_name      = module.devops_eks_cluster.cluster_name
  private_subnet_1a = module.devops_network.subnet_priv_1a
  private_subnet_1b = module.devops_network.subnet_priv_1b
  tags              = local.tags
}

module "devops_instance_ec2" {
  source            = "./modules/instance_ec2"
  subnet_ec2_devops = module.devops_network.subnet_ec2
  vpc_ec2_devops    = module.devops_network.id_vpc
  tags              = local.tags
}

module "devops_secret_rds" {
  source                = "./modules/rds_secret"
  vpc_rds_devops        = module.devops_network.id_vpc
  private_subnet_rds_1a = module.devops_network.subnet_priv_1a
  private_subnet_rds_1b = module.devops_network.subnet_priv_1b
  username_secret       = var.username_secret
  password_secret       = var.password_secret
  name_db_rds           = var.name_db_rds
  tags                  = local.tags
}