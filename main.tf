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
  security_groups    = "sg-0de0bcc29f098a819"
  vpc_id             = "vpc-0cfe33cec30810558"
  target_group_names = ["dev-green-target-group", "dev-blue-target-group"]
  target_group_ports = [80, 80]
}


