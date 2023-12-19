variable "replication_group_id" {
  description = "Replication group identifier.This parameter is stored as a lowercase string" 
  type        = string
}
variable "redis_subnet_ids" {
  description = "List of subnet IDs in the VPC for the Redis cluster."
  type        = list(string)
}

variable "apply_immediately" {
  description = "Redis configuration apply immadiately when something changed"
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Specifies whether minor version engine upgrades will be applied automatically."
  type        = bool
  default     = true
}