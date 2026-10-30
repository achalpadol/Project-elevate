
output "VPC_ID" {
  description = "ID of the VPC"
  value       = aws_vpc.this_vpc.id
}
output "VPC_CIDR" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.this_vpc.cidr_block
}
output "PUBLIC_SUBNET_IDS" {
  description = "IDs of the public subnets"
  value = {
    for KEY, SUBNET in aws_subnet.this_public_subnet :
    KEY => SUBNET.id
  }
}
output "PRIVATE_SUBNET_IDS" {
  description = "IDs of the private subnets"
  value = {
    for KEY, SUBNET in aws_subnet.this_private_subnet :
    KEY => SUBNET.id
  }
}
output "PUBLIC_SUBNET_CIDRS" {
  description = "CIDR blocks of public subnets"
  value = {
    for KEY, SUBNET in aws_subnet.this_public_subnet :
    KEY => SUBNET.cidr_block
  }
}
output "PRIVATE_SUBNET_CIDRS" {
  description = "CIDR blocks of private subnets"
  value = {
    for KEY, SUBNET in aws_subnet.this_private_subnet :
    KEY => SUBNET.cidr_block
  }
}
output "NAT_GATEWAY_ID" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.this_nat_gateway.id
}
