# # ECS Security Group (if not already created)
# resource "aws_security_group" "dev_ecs_sg" {
#   name        = "dev-ecs-sg"
#   description = "Security Group for ECS"
#   vpc_id      = aws_vpc.main.id

#   # Allow traffic from ALB to ECS
#   ingress {
#     from_port       = 8000
#     to_port         = 8000
#     protocol        = "tcp"
#     security_groups = [aws_security_group.dev_alb.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "dev-ecs-sg"
#   }
# }