resource "aws_security_group_rule" "ecs_ingress_alb" {
  type                     = "ingress"
  from_port                = 8000
  to_port                  = 8000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_alb.id
  security_group_id        = aws_security_group.dev_ecs_sg.id
}
