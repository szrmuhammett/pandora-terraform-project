output "service_2_task_arn" {
  value = module.ecs.generic_task.arn
}

output "service_2_service_id" {
  value = module.ecs.ecs_service_id
}