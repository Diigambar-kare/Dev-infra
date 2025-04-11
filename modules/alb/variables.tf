variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "subnets" {
  description = "List of public subnets for the ALB"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security groups for the ALB"
  type        = list(string)
}

variable "target_group_names" {
  description = "Names of the target groups"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be created"
  type        = string
}
