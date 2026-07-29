# 1. AWS Provider Configuration
provider "aws" {
  region = "us-east-1"
}

# 2. Virtual Private Cloud (VPC)
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# 3. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# ==========================================
# SUB NETWORKS (2 Public, 2 App, 2 DB)
# ==========================================

resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.public_subnet_azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_names[count.index]
  }
}

# 5. Private Subnets (Application Tier)
resource "aws_subnet" "private_app" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_cidrs[count.index]
  availability_zone = var.private_app_subnet_azs[count.index]

  tags = {
    Name = var.private_app_subnet_names[count.index]
  }
}
# 6. Private Subnets (Database Tier)
resource "aws_subnet" "private_db" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_cidrs[count.index]
  availability_zone = var.private_db_subnet_azs[count.index]

  tags = {
    Name = var.private_db_subnet_names[count.index]
  }
}
# ==========================================
# NAT GATEWAY SETUP
# ==========================================

# 7. Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "my-ei"
  }
}

# 8. NAT Gateway (Placed in Public Subnet 1)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "my-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
 
# ==========================================
# ROUTE TABLES & ASSOCIATIONS
# ==========================================

# 9. Public Route Table (Points to IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

#Route Table Association

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# 10. Private Route Table (Points to NAT Gateway for App & DB)

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

# App Subnets Association
resource "aws_route_table_association" "app" {
  count = length(aws_subnet.private_app)

  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private.id
}
# DB Subnets Association
resource "aws_route_table_association" "db" {
  count = length(aws_subnet.private_db)

  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private.id
}

