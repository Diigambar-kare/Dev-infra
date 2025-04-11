variable "db_name" {
  type    = string
  default = "devFittBot"
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
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default   = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}
