# Description: The master file that calls all sub-modules and passes data between them.

module "networking" {
  source = "./Network" 
}

module "security" {
  source = "./Security"
  vpc_id = module.networking.vpc_id 
}

module "compute" {
  source = "./Compute"
  vpc_id                = module.networking.vpc_id
  private_subnet_ids    = module.networking.private_subnet_ids 
  alb_security_group_id = module.security.alb_strict_sg_id     
}

module "database" {
  source = "./Storage"
  private_db_subnets   = module.networking.private_subnet_ids
  db_security_group_id = module.security.db_sg_id
}

module "edge" {
  source = "./Edge"
}

