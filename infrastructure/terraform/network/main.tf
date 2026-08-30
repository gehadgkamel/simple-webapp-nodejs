resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "private_zone" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.zones[count.index]

  tags = {
    "Name"                                           = "${var.env}-private-${var.zones[count.index]}"
    "kubernetes.io/role/internal-elb"                = "1"
    "kubernetes.io/cluster/${var.env}-${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public_zone" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.zones[count.index]
  map_public_ip_on_launch = true
  

  tags = {
    "Name"                                           = "${var.env}-public-${var.zones[count.index]}" 
    "kubernetes.io/role/elb"                         = "1"
    "kubernetes.io/cluster/${var.env}-${var.cluster_name}" = "owned"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.env}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_zone[0].id

  tags = {
    Name = "${var.env}-nat"
  }
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.env}-private"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.env}-public"
  }
}

resource "aws_route_table_association" "private_zone" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_zone[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_zone" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_zone[count.index].id
  route_table_id = aws_route_table.public.id
}