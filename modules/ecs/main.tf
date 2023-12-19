resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster"
}

resource "aws_ecs_task_definition" "generic_task" {
  family                   = "generic-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name  = "generic-container",
      image = var.generic_container_image,
    },
  ])
}

