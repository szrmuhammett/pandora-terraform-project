module "ecs" {
  source              = "../ecs"  # Path to the generic ECS module
  ecs_task_role_arn   = var.ecs_task_role_arn
  subnet_id           = module.vpc.subnet_id
  security_group_id   = module.security.security_group_id
  generic_container_image = "your-service-2-image:latest"  # Replace with your image
}
