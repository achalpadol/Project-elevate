# 1. AWS Provider Configuration
provider "aws" {
  region = var.REGION_NAME
}
# 2. Virtual Private Cloud (VPC)
resource "aws_vpc" "this_main" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = var.ENABLE_DNS_SUPPORT
  enable_dns_hostnames = var.ENABLE_DNS_HOSTNAMES
  tags = {
    Name = var.VPC_NAME
  }
}
# 3. Internet Gateway
resource "aws_internet_gateway" "this_igw" {
  vpc_id = aws_vpc.this_main.id
  tags = {
    Name = var.IGW_NAME
  }
}
# SUB NETWORKS (2 Public, 2 App, 2 DB)
resource "aws_subnet" "this_public" {
  count                   = length(var.PUBLIC_SUBNET_CIDRS)
  vpc_id                  = aws_vpc.this_main.id
  cidr_block              = var.PUBLIC_SUBNET_CIDRS[count.index]
  availability_zone       = var.PUBLIC_SUBNET_AZS[count.index]
  map_public_ip_on_launch = var.MAP_PUBLIC_IP_ON_LAUNCH
  tags = {
    Name = var.PUBLIC_SUBNET_NAMES[count.index]
  }
}
# 5. Private Subnets (Application Tier)
resource "aws_subnet" "this_private_app" {
  count             = length(var.PRIVATE_APP_SUBNET_CIDRS)
  vpc_id            = aws_vpc.this_main.id
  cidr_block        = var.PRIVATE_APP_SUBNET_CIDRS[count.index]
  availability_zone = var.PRIVATE_APP_SUBNET_AZS[count.index]
  tags = {
    Name = var.PRIVATE_APP_SUBNET_NAMES[count.index]
  }
}
# 6. Private Subnets (Database Tier)
resource "aws_subnet" "this_private_db" {
  count = length(var.PRIVATE_DB_SUBNET_CIDRS)
  vpc_id            = aws_vpc.this_main.id
  cidr_block        = var.PRIVATE_DB_SUBNET_CIDRS[count.index]
  availability_zone = var.PRIVATE_DB_SUBNET_AZS[count.index]
  tags = {
    Name = var.PRIVATE_DB_SUBNET_NAMES[count.index]
  }
}
# NAT GATEWAY SETUP
# 7. Elastic IP for NAT Gateway
resource "aws_eip" "this_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.this_igw]
  tags = {
    Name = var.MY_ELASTIC_IP
  }
}
# 8. NAT Gateway (Placed in Public Subnet 1)
resource "aws_nat_gateway" "this_nat" {
  allocation_id = aws_eip.this_eip.id
  subnet_id     = aws_subnet.this_public[0].id
  tags = {
    Name = var.MY_NAT_GATEWAY
  }
  depends_on = [aws_internet_gateway.this_igw]
}
# 9. Public Route Table (Points to IGW)
resource "aws_route_table" "this_public" {
  vpc_id = aws_vpc.this_main.id
  route {
    cidr_block = var.PUBLIC_ROUTE_CIDR
    gateway_id = aws_internet_gateway.this_igw.id
  }
  tags = {
    Name = var.PUBLIC_ROUTE_TABLE_NAME
  }
}
#Route Table Association
resource "aws_route_table_association" "this_publicrt_asso" {
  count          = length(aws_subnet.this_public)
  subnet_id      = aws_subnet.this_public[count.index].id
  route_table_id = aws_route_table.this_public.id
}
# 10. Private Route Table (Points to NAT Gateway for App & DB)
resource "aws_route_table" "this_private_rt" {
  vpc_id = aws_vpc.this_main.id
  route {
    cidr_block     = var.PRIVATE_ROUTE_CIDR
    nat_gateway_id = aws_nat_gateway.this_nat.id
  }
  tags = {
    Name = var.PRIVATE_ROUTE_TABLE_NAME
  }
}
# App Subnets Association
resource "aws_route_table_association" "this_app" {
  count          = length(aws_subnet.this_private_app)
  subnet_id      = aws_subnet.this_private_app[count.index].id
  route_table_id = aws_route_table.this_private_rt.id
}
# DB Subnets Association
resource "aws_route_table_association" "db" {
  count          = length(aws_subnet.this_private_db)
  subnet_id      = aws_subnet.this_private_db[count.index].id
  route_table_id = aws_route_table.this_private_rt.id
}

