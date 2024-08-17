resource "aws_subnet" "devops_private_subnet_1a" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = cidrsubnet(var.bloco_cidr, 8, 3)
  availability_zone = "${data.aws_region.current.name}a"
  tags = merge(
    var.tags,
    {
      Name                              = "subnet_privada_1a",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_subnet" "devops_private_subnet_1b" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = cidrsubnet(var.bloco_cidr, 8, 4)
  availability_zone = "${data.aws_region.current.name}b"
  tags = merge(
    var.tags,
    {
      Name                              = "subnet_privada_1b",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_eip" "devops_eip_1a" {
  domain = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "devops-eip_1a"
    }
  )
}

resource "aws_eip" "devops_eip_1b" {
  domain = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "devops_eip_1b"
    }
  )
}

resource "aws_nat_gateway" "devops_ngw_1a" {
  allocation_id = aws_eip.devops_eip_1a.id
  subnet_id     = aws_subnet.devops_public_subnet_1a.id

  tags = {
    Name = "devops_nat_gateway_1a"
  }
}

resource "aws_nat_gateway" "devops_ngw_1b" {
  allocation_id = aws_eip.devops_eip_1b.id
  subnet_id     = aws_subnet.devops_public_subnet_1a.id

  tags = {
    Name = "devops_nat_gateway_1b"
  }
}

resource "aws_route_table" "devops_private_route_table_1a" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.devops_ngw_1a.id
  }

  tags = merge(
    var.tags,
    {
      Name = "ngw_privada_1a"
    }
  )
}

resource "aws_route_table" "devops_private_route_table_1b" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.devops_ngw_1b.id
  }

  tags = merge(
    var.tags,
    {
      Name = "ngw_privada_1b"
    }
  )
}

resource "aws_route_table_association" "asso_private_subnet_1a" {
  subnet_id      = aws_subnet.devops_private_subnet_1a.id
  route_table_id = aws_route_table.devops_private_route_table_1a.id
}

resource "aws_route_table_association" "asso_private_subnet_1b" {
  subnet_id      = aws_subnet.devops_private_subnet_1b.id
  route_table_id = aws_route_table.devops_private_route_table_1b.id
}