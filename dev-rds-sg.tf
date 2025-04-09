# # RDS Security Group (dev-rds-sg)
# resource "aws_security_group" "dev_rds_sg" {
#   name        = "dev-rds-sg"
#   description = "Security Group for RDS allowing traffic from ECS and Launch Wizard"
#   vpc_id      = aws_vpc.main.id  # Replace with your VPC ID

#   # Allow MySQL (3306) from ECS security group
#   ingress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [aws_security_group.dev_ecs_sg.id]
#   }

#   # Allow MySQL (3306) from Launch Wizard 3 security group (Existing SG)
#   ingress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = ["sg-06b7e18016d8cddcc"]  # Replace with your launch-wizard-3 SG ID
#   }

#   # Allow all outbound traffic from RDS
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "dev-rds-sg"
#   }
# }

