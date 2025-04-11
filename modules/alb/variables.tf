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
  default     = ["dev-green-target-group", "dev-blue-target-group"]
}


variable "target_group_ports" {
  description = "Ports for the target groups"
  type        = list(number)
  default     = [80, 80]  # Both target groups use port 80
}
variable "target_group_protocol" {
  description = "Protocol for the target groups"
  type        = string
  default     = "HTTP"
}
variable "vpc_id" {
  description = "VPC ID where the ALB will be created"
  type        = string
}
