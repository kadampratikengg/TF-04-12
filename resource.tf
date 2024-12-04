resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_app" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "PrivateAppSubnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_db" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "PrivateDBSubnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "nat" {
  count                  = length(var.azs)
  allocation_id          = aws_eip.nat[count.index].id
  subnet_id              = aws_subnet.public[count.index].id
  tags = {
    Name = "NATGateway-${count.index + 1}"
  }
}

resource "aws_eip" "nat" {
  count = length(var.azs)
  domain = "vpc"
  tags = {
    Name = "NATEIP-${count.index + 1}"
  }
}

resource "aws_route_table" "private" {
  count  = length(var.azs)
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "PrivateRouteTable-${count.index + 1}"
  }
}

resource "aws_route" "private_route" {
  count                  = length(var.azs)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}

resource "aws_route_table_association" "private_app" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "private_db" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
