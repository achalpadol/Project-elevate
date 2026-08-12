# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this_main.id
}
output "vpc_arn" {
  description = "VPC ARN"
  value       = aws_vpc.this_main.arn
}
output "vpc_cidr" {
  description = "VPC CIDR Block"
  value       = aws_vpc.this_main.cidr_block
}
# Internet Gateway
output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this_igw.id
}
# Public Subnets
output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = aws_subnet.this_public[*].id
}
output "public_subnet_arns" {
  description = "Public Subnet ARNs"
  value       = aws_subnet.this_public[*].arn
}
# Private Application Subnets
output "private_app_subnet_ids" {
  description = "Private Application Subnet IDs"
  value       = aws_subnet.this_private_app[*].id
}
output "private_app_subnet_arns" {
  description = "Private Application Subnet ARNs"
  value       = aws_subnet.this_private_app[*].arn
}
# Private Database Subnets
output "private_db_subnet_ids" {
  description = "Private Database Subnet IDs"
  value       = aws_subnet.this_private_db[*].id
}
output "private_db_subnet_arns" {
  description = "Private Database Subnet ARNs"
  value       = aws_subnet.this_private_db[*].arn
}
# Elastic IP
output "nat_eip_id" {
  description = "Elastic IP ID"
  value       = aws_eip.this_eip.id
}
output "nat_public_ip" {
  description = "NAT Gateway Public IP"
  value       = aws_nat_gateway.this_nat.id
}
# NAT Gateway
output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.this_nat.id
}
# Public Route Table
output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.this_public.id
}
# Private Route Table
output "private_route_table_id" {
  description = "Private Route Table ID"
  value       = aws_route_table.this_private_rt
}
