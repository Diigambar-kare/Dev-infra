# Redis Security Group (dev-redis-sg)
resource "aws_security_group" "dev_redis_sg" {
  name        = "dev-redis-sg"
  description = "Security Group for Redis allowing traffic from ECS"
  vpc_id      = aws_vpc.main.id

  # Allow Redis (6379) from ECS security group
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.dev_ecs_sg.id]
  }

  # Allow Redis (6379) from dev-redis-sg itself
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [sg-06b7e18016d8cddcc]
  }

  # Allow all outbound traffic from Redis
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev-redis-sg"
  }
}





















