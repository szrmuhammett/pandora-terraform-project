variable "security_group_name" {
  description = "Name of the security group"
}
variable "environment" {
  description = "Environment name"
}

variable "security_group_description" {
  description = "Description of the security group"
}

variable "vpc_id" {
  description = "ID of the VPC to associate with the security group"
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "egress_rules" {
  description = "List of egress rules"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "tags" {
  description = "Map of tags for the VPC resources"
  type        = map(string)
}
