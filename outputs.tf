output "vpc_id" {
  value = module.vpc.vpc_id
}

output "security_group_id" {
  value = module.security.security_group_id
}

output "ecs_task_role_arn" {
  value = module.iam.ecs_task_role_arn
}
output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "redis_endpoint" {
  value = module.elasticache.redis_endpoint
}
output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}

output "ecs_service_id" {
  value = module.ecs.ecs_service_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "nlb_dns_name" {
  value = module.nlb.nlb_dns_name
}

output "route53_zone_id" {
  value = module.route53.route53_zone_id
}