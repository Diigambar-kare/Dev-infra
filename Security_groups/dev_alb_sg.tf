# resource "aws_security_group" "dev_alb" {
#   name        = "dev-alb"
#   description = "Security Group for Load Balancer"
#   vpc_id      = var.vpc_id  # Ensure var.vpc_id is correctly passed during apply

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "dev-alb"
#   }
# }

