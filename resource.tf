
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  tags = {
    Name = "MyVPC"
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