provider "aws" {
  region = "eu-central-1"  # Change this to your preferred AWS region
}

module "vpc" {
  source = "../modules/vpc"
}

module "security" {
  source = "../modules/security"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source = "../global/iam"
}

module "rds" {
  source      = "../modules/rds"
  db_username = "your_db_username"
  db_password = "your_db_password"
  # Include any necessary variables
}

module "redis" {
  source              = "../modules/redis"
  security_group_id   = module.security.security_group_id
}

module "ecs" {
  source = "../modules/ecs"
  ecs_task_role_arn = module.iam.ecs_task_role_arn
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.security.security_group_id
  container_image   = "your-common-service-image:latest"  # Replace with your image
  desired_count     = 1
}
module "alb" {
  source    = "../modules/alb"
  subnet_id = module.vpc.subnet_id
}

module "nlb" {
  source    = "../modules/nlb"
  subnet_id = module.vpc.subnet_id
}

module "route53" {
  source = "../modules/route53"
  vpc_id = module.vpc.vpc_id
}

module "ecs_service_organization" {
  source = "../modules/ecs_services/organizations"
  # Include any necessary variables
  ecs_cluster_id   = module.ecs.ecs_cluster_id
  ecs_service_id   = module.ecs.ecs_service_id
}

module "ecs_service_otc" {
  source = "../modules/ecs_services/otc"
  # Include any necessary variables
  ecs_cluster_id   = module.ecs.ecs_cluster_id
  ecs_service_id   = module.ecs.ecs_service_id
}

module "ecs_service_main" {
  source = "../modules/ecs_services/main"
  # Include any necessary variables
  ecs_cluster_id   = module.ecs.ecs_cluster_id
  ecs_service_id   = module.ecs.ecs_service_id
}

module "ecs_service_processors" {
  source = "../modules/ecs_services/processors"
  # Include any necessary variables
  ecs_cluster_id   = module.ecs.ecs_cluster_id
  ecs_service_id   = module.ecs.ecs_service_id
}

module "ecs_service_dashboard" {
  source = "../modules/ecs_services/dashboard"
  # Include any necessary variables
  ecs_cluster_id   = module.ecs.ecs_cluster_id
  ecs_service_id   = module.ecs.ecs_service_id
}

module "ecs_service_processors" {
  source = "../modules/ecs_services/processors"
  # Include any necessary variables
  ecs_cluster_id   = module.ecs.ecs_cluster_id
  ecs_service_id   = module.ecs.ecs_service_id
}

module "ecs_service_newrelic-infra" {
  source = "../modules/ecs_services/newrelic-infra"
  # Include any necessary variables
  ecs_cluster_id   = module.ecs.ecs_cluster_id
  ecs_service_id   = module.ecs.ecs_service_id
}