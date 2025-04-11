# Create ALB
resource "aws_lb" "dev_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = {
    Name = var.lb_name
  }
}

# Create Target Groups
resource "aws_lb_target_group" "target_groups" {
  count       = length(var.target_group_names)
  name        = var.target_group_names[count.index]
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = var.target_group_names[count.index]
  }
}

# Create ALB Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.dev_lb.arn
  port              = 8000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_groups[0].arn # Blue TG as default
  }
}
