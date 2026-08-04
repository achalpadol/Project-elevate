region_name = "us-east-1"
vpc_cidr = "10.0.0.0/16"
enable_dns_support = true
enable_dns_hostnames = true
vpc_name = "main-vpc"
igw_name = "main-igw"

# Public Subnets

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

public_subnet_azs = [
  "us-east-1a",
  "us-east-1b"
]

public_subnet_names = [
  "public-web-1a",
  "public-web-1b"
]
map_public_ip_on_launch = true
-----------------------------------
# Private App Subnets

private_app_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

private_app_subnet_azs = [
  "us-east-1a",
  "us-east-1b"
]

private_app_subnet_names = [
  "private-app-1a",
  "private-app-1b"
]
----------------------------------
# Private DB Subnets

private_db_subnet_cidrs = [
  "10.0.21.0/24",
  "10.0.22.0/24"
]

private_db_subnet_azs = [
  "us-east-1a",
  "us-east-1b"
]

private_db_subnet_names = [
  "private-db-1a",
  "private-db-1b"
]
my_elasti_ip = "my-eip"
my_nat_gateway = "my-nat"

private_route_cidr = "0.0.0.0/0"
private_route_table_name = "private-rt"
public_route_cidr = "0.0.0.0/0"
public_route_table_name = "public-rt"
--------------------------------------
# SG tfvars

sg_name = [
    "alb-sg",
    "app-sg",
    "db-sg"
]

alb_ports = [80, 443]
app_ports = [80]
db_ports = [3306]

alb_ingress_cidr = [
  "0.0.0.0/0"
]
# Outbound CIDR

egress_cidr = ["0.0.0.0/0"] 

# Egress
egress_from_port = 0
egress_to_port = 0
egress_protocol = "-1"
ingress_protocol = "tcp"
-------------------------------------------
# RDS tfvars
db_subnet_group_name = "my-db-subnet-group"
db_identifier = "my-rds"
engine = "mysql"
engine_version = "8.0"
instance_class = "db.t3.micro"
allocated_storage = 20
storage_type = "gp2"
db_name = "mydatabase"
username = "admin"
password = "Admin12345"
publicly_accessible = false
skip_final_snapshot = true
---------------------------------------
# ALB tfvars
alb_name = "my-alb"
internal = false
load_balancer_type = "application"
enable_deletion_protection = false
target_group_name = "my-target-group"
target_group_port = 80
target_group_protocol = "HTTP"
listener_port = 80
listener_protocol = "HTTP"
default_action_type = "forward"
health_check_path = "/"

--------------------------------------------
# ec2 tfvars
ami_id = "ami-0b6d9d3d33ba97d99"
instance_type = "m7i-flex.large"
instance_name = "application-server"
key_name = "terraform-key"
key_algorithm = "RSA"
rsa_bits = 4096
private_key_filename = "terraform-key.pem"
public_key_path =  "/mnt/c/Users/admin/Downloads/"
--------------------------------------------------------
# IAM role tfvars for session manager
iam_role_name = "EC2-SSM-Role"
instance_profile_name = "EC2-SSM-Profile"
ssm_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
