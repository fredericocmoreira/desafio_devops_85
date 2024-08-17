resource "aws_subnet" "devops_public_subnet_ec2" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = cidrsubnet(var.bloco_cidr, 8, 5)
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_region.current.name}a"
  tags = merge(
    var.tags,
    {
      Name = "ec2_subnet_publica"
    }
  )
}

resource "aws_route_table" "devops_public_route_ec2" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id
  }

  tags = merge(
    var.tags,
    {
      Name = "ec2_publico"
    }
  )
}

resource "aws_route_table_association" "asso_public_subnet_ec2" {
  subnet_id      = aws_subnet.devops_public_subnet_ec2.id
  route_table_id = aws_route_table.devops_public_route_ec2.id
}
