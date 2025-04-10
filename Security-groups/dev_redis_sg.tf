resource "aws_security_group" "dev_redis_sg" {
  name        = "dev-redis-sg"
  description = "Security Group for Redis"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-redis-sg" }
}
