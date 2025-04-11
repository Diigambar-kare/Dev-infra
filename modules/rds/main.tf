resource "aws_db_instance" "dev_fittbot_db" {
  identifier           = "devfittbotdb"
  engine              = "mysql"
  instance_class      = "db.t4g.micro"
  allocated_storage   = 20
  storage_type        = "gp2"
  db_name             = var.db_name
  username           = var.username
  password           = var.password
  port               = 3306
  publicly_accessible = false
  vpc_security_group_ids = [var.security_group]  # Taking SG from variable
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "RDS Private Subnet Group"
    VPC  = var.vpc_id  # Ensure this VPC is referenced
  }
}
