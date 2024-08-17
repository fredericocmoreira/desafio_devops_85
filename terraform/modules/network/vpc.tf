resource "aws_vpc" "devops_vpc" {
  cidr_block           = var.bloco_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.tags,
    {
      Name = "desafio_devops_vpc"
    }
  )
}