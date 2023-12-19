output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.example_sg.id
}