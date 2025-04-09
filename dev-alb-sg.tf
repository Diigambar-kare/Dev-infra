# # Load Balancer Security Group (dev-alb)
# resource "aws_security_group" "dev_alb" {
#   name        = "dev-alb"
#   description = "Security Group for Load Balancer"
#   vpc_id      = aws_vpc.main.id

#   # Allow incoming traffic on port 3100 from any IP
#   ingress {
#     from_port   = 3100
#     to_port     = 3100
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Allow incoming HTTPS traffic (443) from any IP
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Allow incoming MySQL traffic (3306) from dev-rds-sg
#   ingress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [aws_security_group.dev_rds_sg.id]
#   }

#   # Allow custom traffic from dev-rds-sg
#   ingress {
#     from_port       = 0
#     to_port         = 65535
#     protocol        = "tcp"
#     security_groups = [aws_security_group.dev_rds_sg.id]
#   }

#   # Allow all outbound traffic
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = { Name = "dev-alb" }
# }

