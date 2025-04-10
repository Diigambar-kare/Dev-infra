module "vpc" {
  source = "./modules/vpc"

  vpc_cidr          = "10.0.0.0/16"
  vpc_name          = "fittbot-Dev-VPC"
  availability_zones = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}
