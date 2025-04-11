variable "name" {
  description = "Name of the Redis cluster"
  type        = string
}

variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type    = string
  default = "Fittbot1234"
}

variable "security_group" {
  description = "Security group ID for Redis"
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for Redis"
  type = list(string)
}

variable "vpc_id" {
  description = "VPC ID for Redis"
  type = string
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default   = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}
