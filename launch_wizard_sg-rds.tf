resource "aws_security_group" "launch_wizard_sg" {
  name        = "launch-wizard-sg-rds"
  description = "Security Group for Launch Wizard"
  vpc_id      = "var.vpc_id" # Replace with your VPC ID

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "launch-wizard-sg-rds"
  }
}
