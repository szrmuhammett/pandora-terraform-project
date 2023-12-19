variable "environment" {
  description = "Environment name (e.g., staging, production)"
  type        = string
}

variable "rds_subnet_ids" {
  description = "List of subnet IDs in the VPC for the Redis cluster."
  type        = list(string)
}

variable "master_password" {
  description = "DB password"
  type        = string
}

variable "master_username" {
  description = "DB username"
  type        = string
}

variable "instance_class" {
  description = "DB instance class"
  type        = string
}

variable "engine_version" {
  description = "DB engine version"
  type        = string
}