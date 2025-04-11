resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "Redis Private Subnet Group"
  }
}

resource "aws_elasticache_cluster" "dev_fittbot_redis" {
  cluster_id           = var.name
  engine              = "redis"
  node_type           = "cache.t4g.micro"
  num_cache_nodes     = 1
  parameter_group_name = "default.redis7"
  subnet_group_name   = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids  = [var.security_group]
  port                = 6379

  tags = {
    Name = var.name
  }
}
