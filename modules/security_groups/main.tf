resource "aws_security_group" "dev_alb" {
  name        = "dev-alb"
  description = "Security Group for Load Balancer"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-alb" }
}

resource "aws_security_group_rule" "alb_ingress_http" {
  type              = "ingress"
  from_port         = 3100
  to_port           = 3100
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dev_alb.id
}

resource "aws_security_group_rule" "alb_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dev_alb.id
}

resource "aws_security_group_rule" "alb_ingress_rds" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_rds_sg.id
  security_group_id        = aws_security_group.dev_alb.id
}

resource "aws_security_group" "dev_ecs_sg" {
  name        = "dev-ecs-sg"
  description = "Security Group for ECS"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-ecs-sg" }
}

resource "aws_security_group_rule" "ecs_ingress_alb" {
  type                     = "ingress"
  from_port                = 8000
  to_port                  = 8000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_alb.id
  security_group_id        = aws_security_group.dev_ecs_sg.id
}

resource "aws_security_group" "dev_rds_sg" {
  name        = "dev-rds-sg"
  description = "Security Group for RDS"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-rds-sg" }
}

resource "aws_security_group_rule" "rds_ingress_ecs" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_ecs_sg.id
  security_group_id        = aws_security_group.dev_rds_sg.id
}

resource "aws_security_group" "launch_wizard_sg" {
  name        = "launch-wizard-sg-rds"
  description = "Security Group for Launch Wizard"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "launch-wizard-sg-rds" }
}

resource "aws_security_group_rule" "rds_ingress_launch_wizard" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.launch_wizard_sg.id
  security_group_id        = aws_security_group.dev_rds_sg.id
}

resource "aws_security_group_rule" "launch_wizard_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.launch_wizard_sg.id
  cidr_blocks       = ["0.0.0.0/0"]  # Open to all, restrict for security
}
