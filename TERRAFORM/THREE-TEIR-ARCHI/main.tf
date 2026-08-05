module "vpc" {
  source = "./modules/VPC"
  # VPC
  vpc_cidr             = var.mod_vpc_cidr
  enable_dns_support   = var.mod_vpc_cidr
  enable_dns_hostnames = var.mod_enable_dns_hostnames
  vpc_name             = var.mod_vpc_name
  igw_name             = var.mod_igw_name
  region_name          = var.mod_region_name
  # Public Subnets
  public_subnet_cidrs     = var.public_subnet_cidrs
  public_subnet_azs       = var.public_subnet_azs
  public_subnet_names     = var.public_subnet_names
  map_public_ip_on_launch = var.map_public_ip_on_launch
  # Private Application Subnets
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_app_subnet_azs   = var.private_app_subnet_azs
  private_app_subnet_names = var.private_app_subnet_names
  # Private Database Subnets
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  private_db_subnet_azs    = var.private_db_subnet_azs
  private_db_subnet_names  = var.private_db_subnet_names
  my_elastic_ip            = var.my_elastic_ip
  my_nat_gateway           = var.my_nat_gateway
  private_route_cidr       = var.private_route_cidr
  private_route_table_name = var.private_route_table_name
  public_route_cidr        = var.public_route_cidr
  public_route_table_name  = var.public_route_table_name
}
module "security_group" {
  source           = "./modules/SG"
  vpc_id           = module.vpc.vpc_id
  sg_name          = var.sg_name
  alb_ports        = var.alb_ports
  app_ports        = var.app_ports
  db_ports         = var.db_ports
  alb_ingress_cidr = var.alb_ingress_cidr
  ingress_protocol = var.ingress_protocol
  egress_cidr      = var.egress_cidr
  egress_from_port = var.egress_from_port
  egress_to_port   = var.egress_to_port
  egress_protocol  = var.egress_protocol
}
module "rds" {
  source                = "./modules/RDS"
  db_subnet_group_name  = var.db_subnet_group_name
  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  db_security_group_id  = module.security_group.db_sg_id
  db_identifier         = var.db_identifier
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  storage_type          = var.storage_type
  db_name               = var.db_name
  username              = var.username
  password              = var.password
  publicly_accessible   = var.publicly_accessible
  skip_final_snapshot   = var.skip_final_snapshot
}
module "alb" {
  source                     = "./modules/ALB"
  alb_name                   = var.alb_name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  alb_security_group_id      = module.security_group.alb_sg_id
  public_subnet_ids          = module.vpc.public_subnet_ids
  enable_deletion_protection = var.enable_deletion_protection
  vpc_id                     = module.vpc.vpc_id
  target_group_name          = var.target_group_name
  target_group_port          = var.target_group_port
  target_group_protocol      = var.target_group_protocol
  health_check_path          = var.health_check_path
  listener_port              = var.listener_port
  listener_protocol          = var.listener_protocol
  default_action_type        = var.default_action_type
  instance_id                = module.ec2.instance_id
}
module "ec2" {
  source                = "./modules/EC2"
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  instance_name         = var.instance_name
  private_app_subnet_id = module.vpc.private_app_subnet_ids[0]
  app_security_group_id = module.security_group.app_sg_id
  iam_instance_profile  = module.iam.instance_profile_name
  public_key_path       = var.public_key_path
  key_name              = var.key_name
  key_algorithm         = var.key_algorithm
  rsa_bits              = var.rsa_bits
  private_key_filename  = var.private_key_filename
}
module "iam" {
  source                = "./modules/IAM"
  iam_role_name         = var.iam_role_name
  instance_profile_name = var.instance_profile_name
  ssm_policy_arn        = var.ssm_policy_arn
}


