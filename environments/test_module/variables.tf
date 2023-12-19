variable "region" {
  description = "AWS region"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}
variable "environment" {
  description = "Environment name"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}

variable "name" {
  description = "Route53 Hosted Name"
  type        = string
  default     = "xyzteknoloji.com"
}

variable "comment" {
  description = "Route53 Hosted Comment"
  type        = string
  default     = "xyzteknoloji.com private hosted zone"
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


