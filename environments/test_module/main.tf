provider "aws" {
  region = var.region  # Set your desired region
}

data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

module "my_vpc" {
  source              = "../../modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  availability_zones  = var.availability_zones
  environment         = var.environment
  tags                = var.tags
  
}

module "my_redis" {
  source               = "../../modules/redis"
  redis_subnet_ids     = module.my_vpc.private_subnet_ids
  replication_group_id = "pandora-${var.environment}-redis-cluster"
  depends_on          = [module.my_vpc]
  
}


module "my_rds" {
  source               = "../../modules/rds"
  rds_subnet_ids       = module.my_vpc.private_subnet_ids
  environment          = var.environment
  master_password      = var.master_password
  master_username      = var.master_username
  instance_class       = var.instance_class
  engine_version       = var.engine_version  
  
  
  
  depends_on           = [module.my_vpc]
}

module "route53" {
  source = "../../modules/route53"
  vpc_id = module.my_vpc.vpc_id
  name = var.name
  comment=var.comment

}
