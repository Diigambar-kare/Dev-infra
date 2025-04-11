# ALB Security Group
resource "aws_security_group" "dev_alb" {
  name        = "dev-alb-sg"
  description = "Security Group for Load Balancer"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-alb-sg" }
}

# ALB Allow All Traffic
resource "aws_security_group_rule" "alb_ingress_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dev_alb.id
}

# ALB Allow HTTP
resource "aws_security_group_rule" "alb_ingress_http" {
  type              = "ingress"
  from_port         = 3100
  to_port           = 3100
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dev_alb.id
}

# ALB Allow HTTPS
resource "aws_security_group_rule" "alb_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dev_alb.id
}

# ALB Allow RDS Connection
resource "aws_security_group_rule" "alb_ingress_rds" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_rds_sg.id
  security_group_id        = aws_security_group.dev_alb.id
}

# ECS Security Group
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

# ECS Allow ALB Traffic
resource "aws_security_group_rule" "ecs_ingress_alb" {
  type                     = "ingress"
  from_port                = 8000
  to_port                  = 8000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_alb.id
  security_group_id        = aws_security_group.dev_ecs_sg.id
}

# RDS Security Group
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

# RDS Allow ECS Traffic
resource "aws_security_group_rule" "rds_ingress_ecs" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_ecs_sg.id
  security_group_id        = aws_security_group.dev_rds_sg.id
}

# Launch Wizard Security Group
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

# Launch Wizard Allow RDS Access
resource "aws_security_group_rule" "rds_ingress_launch_wizard" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.launch_wizard_sg.id
  security_group_id        = aws_security_group.dev_rds_sg.id
}

# Launch Wizard Allow SSH
resource "aws_security_group_rule" "launch_wizard_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.launch_wizard_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Redis Security Group
resource "aws_security_group" "dev_redis_sg" {
  name        = "dev-redis-sg"
  description = "Security Group for Redis"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-redis-sg" }
}

# Redis Allow ECS Access
resource "aws_security_group_rule" "redis_ingress_ecs" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_ecs_sg.id
  security_group_id        = aws_security_group.dev_redis_sg.id
}

# Redis Allow Launch Wizard Access
resource "aws_security_group_rule" "redis_ingress_launch_wizard" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.launch_wizard_sg.id
  security_group_id        = aws_security_group.dev_redis_sg.id
}
