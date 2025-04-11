# resource "aws_security_group_rule" "redis_ingress_ecs" {
#   type                     = "ingress"
#   from_port                = 6379
#   to_port                  = 6379
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.dev_ecs_sg.id
#   security_group_id        = aws_security_group.dev_redis_sg.id
# }

# resource "aws_security_group_rule" "redis_ingress_launch_wizard" {
#   type                     = "ingress"
#   from_port                = 6379
#   to_port                  = 6379
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.launch_wizard_sg.id  # Launch Wizard SG ID
#   security_group_id        = aws_security_group.dev_redis_sg.id
# }
