module "vpc" {
  source = "./modules/vpc"

  vpc_cidr          = "10.0.0.0/16"
  vpc_name          = "fittbot-Dev-VPC"
  availability_zones = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}
module "security" {
  source = "./modules/security_groups"
  vpc_id = "vpc-0cfe33cec30810558"
}
module "alb" {
  source             = "./modules/alb"
  lb_name            = "dev-lb"
  subnets            = ["subnet-0b0e8dda10f4f380d", "subnet-07945cee900c0ca7c", "subnet-01edb5fa9c7dc796d"]
  security_groups = ["sg-0de0bcc29f098a819"]  # ✅ Correct (List format)
  vpc_id             = "vpc-0cfe33cec30810558"
  target_group_names = ["dev-green-target-group", "dev-blue-target-group"]
  target_group_ports = [80, 80]
}
module "iam_roles" {
  source = "./modules/iam_roles"
}
module "rds" {
  source          = "./modules/rds"
  db_name        = "dev-fittbot-db"
  username       = "admin"
  password       = "Fittbot@1234"
  security_group = "sg-0d18be5de87aadfd1"  # Now passed from here
  subnet_ids     = [
    "subnet-0c5b48a7e83d0f147",
    "subnet-009f431521e64f280",
    "subnet-02080e43952fc7cbd"
  ]
}
