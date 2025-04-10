module "security_groups" {
  source  = "./Security_groups"
  vpc_id  = var.vpc_id
}
