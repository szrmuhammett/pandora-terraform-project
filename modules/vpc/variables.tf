variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "environment" {
  description = "Environment name (e.g., staging, production)"
  type        = string
}

variable "tags" {
  description = "Map of tags for the VPC resources"
  type        = map(string)
}
