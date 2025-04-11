variable "db_name" {
  type    = string
  default = "devfittbotdb"
}

variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type    = string
  default = "Fittbot@1234"
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
