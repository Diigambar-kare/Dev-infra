# resource "aws_security_group" "dev_ecs_sg" {
#   name        = "dev-ecs-sg"
#   description = "Security Group for ECS"
#   vpc_id      = "var.vpc_id"

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = { Name = "dev-ecs-sg" }
# }
