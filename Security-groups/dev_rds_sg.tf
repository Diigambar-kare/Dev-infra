resource "aws_security_group" "dev_rds_sg" {
  name        = "dev-rds-sg"
  description = "Security Group for RDS"
  vpc_id      = "var.vpc_id"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-rds-sg" }
}
