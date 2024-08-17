resource "aws_subnet" "devops_public_subnet_1a" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = cidrsubnet(var.bloco_cidr, 8, 1)
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_region.current.name}a"
  tags = merge(
    var.tags,
    {
      Name                     = "subnet_publica_1a",
      "kubernetes.io/role/elb" = 1
    }
  )
}

resource "aws_subnet" "devops_public_subnet_1b" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = cidrsubnet(var.bloco_cidr, 8, 2)
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_region.current.name}b"
  tags = merge(
    var.tags,
    {
      Name                     = "subnet_publica_1b",
      "kubernetes.io/role/elb" = 1
    }
  )
}

resource "aws_internet_gateway" "devops_igw" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = merge(
    var.tags,
    {
      Name = "devops-gateway"
    }
  )
}

resource "aws_route_table" "devops_public_route_table" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id
  }

  tags = merge(
    var.tags,
    {
      Name = "rt_publica"
    }
  )
}

resource "aws_route_table_association" "asso_public_subnet_1a" {
  subnet_id      = aws_subnet.devops_public_subnet_1a.id
  route_table_id = aws_route_table.devops_public_route_table.id
}

resource "aws_route_table_association" "asso_public_subnet_1b" {
  subnet_id      = aws_subnet.devops_public_subnet_1b.id
  route_table_id = aws_route_table.devops_public_route_table.id
}
