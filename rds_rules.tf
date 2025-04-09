resource "aws_security_group_rule" "rds_ingress_ecs" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_ecs_sg.id
  security_group_id        = aws_security_group.dev_rds_sg.id
}

resource "aws_security_group_rule" "rds_ingress_launch_wizard" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "sg-06b7e18016d8cddcc"  # Launch Wizard SG ID
  security_group_id        = aws_security_group.dev_rds_sg.id
}
