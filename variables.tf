variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "vpc_id" {
  description = "vpc id for the envirnment "
  type        = string
}

variable "subnets" {
  description = "List of public subnets for the ALB"
  type        = list(string)
}