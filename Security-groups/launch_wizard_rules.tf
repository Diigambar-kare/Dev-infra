# Allow SSH (22) from any IP (Restrict for security)
resource "aws_security_group_rule" "launch_wizard_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.launch_wizard_sg.id
  cidr_blocks       = ["0.0.0.0/0"]  # Open to all, restrict for security
}
