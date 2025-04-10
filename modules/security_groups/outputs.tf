output "alb_security_group_id" {
  value = aws_security_group.dev_alb.id
}

output "ecs_security_group_id" {
  value = aws_security_group.dev_ecs_sg.id
}

output "rds_security_group_id" {
  value = aws_security_group.dev_rds_sg.id
}

output "launch_wizard_security_group_id" {
  value = aws_security_group.launch_wizard_sg.id
}
