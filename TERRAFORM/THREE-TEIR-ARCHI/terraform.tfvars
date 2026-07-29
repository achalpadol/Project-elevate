
vpc_cidr = "10.0.0.0/16"

##################################
# Public Subnets
##################################

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

##################################
# Private App Subnets
##################################

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

##################################
# Private DB Subnets
##################################

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

# SG tfvars

sg_name = [
    "alb-sg",
    "app-sg",
    "db-sg"
]

alb_ports = [80, 443]
app_ports = [80]
db_ports = [3306]

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

# ALB tfvars
alb_name = "my-alb"

target_group_name = "my-target-group"

target_group_port = 80

listener_port = 80

# ec2 tfvars
ami_id = "ami-0c02fb55956c7d316"

instance_type = "t3.micro"

instance_name = "application-server"

key_name = "my-keypair"

public_key_path =  "/mnt/c/Users/admin/Downloads/"

# IAM role tfvars for session manager
iam_role_name = "EC2-SSM-Role"

instance_profile_name = "EC2-SSM-Profile"

ssm_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
