module "vpc" {
  source = "./modules/vpc"

  # VPC
  vpc_cidr = var.vpc_cidr

  # Public Subnets
  public_subnet_cidrs = var.public_subnet_cidrs
  public_subnet_azs   = var.public_subnet_azs
  public_subnet_names = var.public_subnet_names

  # Private Application Subnets
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_app_subnet_azs   = var.private_app_subnet_azs
  private_app_subnet_names = var.private_app_subnet_names

  # Private Database Subnets
  private_db_subnet_cidrs = var.private_db_subnet_cidrs
  private_db_subnet_azs   = var.private_db_subnet_azs
  private_db_subnet_names = var.private_db_subnet_names
}

module "security_group" {
  source = "./modules/SG"

  vpc_id = module.vpc.vpc_id

  sg_name = var.sg_name
  alb_ports = var.alb_ports
  app_ports = var.app_ports
  db_ports = var.db_ports
}

module "rds" {

  source = "./modules/RDS"

  db_subnet_group_name = var.db_subnet_group_name

  private_db_subnet_ids = module.vpc.private_db_subnet_ids

  db_security_group_id = module.security_group.db_sg_id

  db_identifier = var.db_identifier

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  db_name  = var.db_name
  username = var.username
  password = var.password
}
module "alb" {

  source = "./modules/ALB"

  alb_name = var.alb_name

  vpc_id = module.vpc.vpc_id

  alb_security_group_id = module.security_group.alb_sg_id

  public_subnet_ids = module.vpc.public_subnet_ids

  target_group_name = var.target_group_name
  target_group_port = var.target_group_port

  listener_port = var.listener_port
}
module "ec2" {
  source = "./modules/EC2"

  ami_id                  = var.ami_id
  instance_type           = var.instance_type
  private_app_subnet_id   = module.vpc.private_app_subnet_ids[0]
  app_security_group_id   = module.security_group.app_sg_id

  key_name        = var.key_name
  public_key_path = var.public_key_path
  instance_name = var.instance_name
  iam_instance_profile = module.iam.instance_profile_name
}

module "iam" {

  source = "./modules/IAM"
  iam_role_name         = var.iam_role_name
  instance_profile_name = var.instance_profile_name
  ssm_policy_arn        = var.ssm_policy_arn

}

