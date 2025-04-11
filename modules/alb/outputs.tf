output "alb_arn" {
  value = aws_lb.dev_lb.arn
}

output "alb_dns_name" {
  value = aws_lb.dev_lb.dns_name
}

output "target_group_arns" {
  value = aws_lb_target_group.target_groups[*].arn
}
