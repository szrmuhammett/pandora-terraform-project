resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  # Attach policies granting necessary permissions for ECS tasks
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_task_role.name
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}