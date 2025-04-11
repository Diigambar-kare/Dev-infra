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
  lb_name           = "dev-lb"
  subnets           = module.vpc.public_subnets
  security_groups   = [module.security_groups.alb_sg]
  target_group_names = ["dev-green-target-group,dev-blue-target-group"]
  vpc_id            = "pc-0cfe33cec30810558"
}
