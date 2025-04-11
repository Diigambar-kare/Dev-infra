module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr          = "10.0.0.0/16"
  vpc_name          = "fittbot-Dev-VPC"
  availability_zones = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}

module "security" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id  # ✅ Use module output instead of hardcoded ID
}

module "alb" {
  source             = "./modules/alb"
  lb_name            = "dev-lb"
  subnets            = ["subnet-0b0e8dda10f4f380d", "subnet-07945cee900c0ca7c", "subnet-01edb5fa9c7dc796d"]
  security_groups    = ["sg-0de0bcc29f098a819"]
  vpc_id             = module.vpc.vpc_id  # ✅ Use module output instead of hardcoded ID
  target_group_names = ["dev-blue-target-group", "dev-green-target-group"]
  target_group_ports = [80, 80]
}

module "iam_roles" {
  source = "./modules/iam_roles"
}

module "rds" {
  source          = "./modules/rds"
  db_name        = "devFittBot"
  username       = "admin"
  password       = "Fittbot1234"
  security_group = "sg-0d18be5de87aadfd1"
  subnet_ids     = [
    "subnet-0c5b48a7e83d0f147",
    "subnet-009f431521e64f280",
    "subnet-02080e43952fc7cbd"
  ]
  vpc_id             = module.vpc.vpc_id  # ✅ Use module output instead of hardcoded ID
  availability_zones = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}

module "redis" {
  source             = "./modules/redis"
  name               = "dev-fittbot-redis"
  security_group     = "sg-0199efcc47aec5390"
  subnet_ids         = [
    "subnet-0c5b48a7e83d0f147",
    "subnet-009f431521e64f280",
    "subnet-02080e43952fc7cbd"
  ]
  vpc_id             = module.vpc.vpc_id  # ✅ Use module output instead of hardcoded ID
  availability_zones = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}
