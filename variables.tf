variable "vpc_id" {
  type = string
}

output "vpc_id" {
  value = aws_vpc.fittbot_dev_vpc.id
}
