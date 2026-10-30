# VPC
resource "aws_vpc" "this_vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.VPC_NAME
    }
  )
}
# Internet Gateway
resource "aws_internet_gateway" "this_igw" {
  vpc_id = aws_vpc.this_vpc.id

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-igw"
    }
  )
}
# Public Subnets
resource "aws_subnet" "this_public_subnet" {
  for_each                = var.PUBLIC_SUBNETS
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = each.value.CIDR
  availability_zone       = each.value.AZ
  map_public_ip_on_launch = true

  tags = merge(
    var.COMMON_TAGS,
    {
      Name                     = each.value.NAME
      "kubernetes.io/role/elb" = "1"
    }
  )
}
# Private Subnets
resource "aws_subnet" "this_private_subnet" {
  for_each                = var.PRIVATE_SUBNETS
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = each.value.CIDR
  availability_zone       = each.value.AZ
  map_public_ip_on_launch = false
  tags = merge(
    var.COMMON_TAGS,
    {
      Name                              = each.value.NAME
      "kubernetes.io/role/internal-elb" = "1"
    }
  )
}
# Public Route Table
resource "aws_route_table" "this_public_route_table" {
  vpc_id = aws_vpc.this_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this_igw.id
  }
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-public-rt"
    }
  )
}
# Public Route Table Association
resource "aws_route_table_association" "this_public_association" {
  for_each       = aws_subnet.this_public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.this_public_route_table.id
}
# Elastic IP for NAT Gateway
resource "aws_eip" "this_nat_eip" {
  domain = "vpc"
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-nat-eip"
    }
  )
}
# NAT Gateway
# Place it in the first public subnet.
resource "aws_nat_gateway" "this_nat_gateway" {
  allocation_id = aws_eip.this_nat_eip.id
  subnet_id     = aws_subnet.this_public_subnet[var.NAT_SUBNET_KEY].id
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-nat"
    }
  )
  depends_on = [
    aws_internet_gateway.this_igw
  ]
}
# Private Route Table
resource "aws_route_table" "this_private_route_table" {
  vpc_id = aws_vpc.this_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this_nat_gateway.id
  }

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-private-rt"
    }
  )
}
# Private Route Table Association
resource "aws_route_table_association" "this_private_association" {
  for_each       = aws_subnet.this_private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.this_private_route_table.id
}
