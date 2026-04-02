# Description: The master file that calls all sub-modules and passes data between them.

module "networking" {
  # Tells Terraform where to find the code
  source = "./Network" 
}

module "security" {
  source = "./Security"
  # Passes the VPC ID from the networking module into the security module
  vpc_id = module.networking.vpc_id 
}

module "compute" {
  source = "./Compute"
  # Passes data from network and security into compute
  vpc_id            = module.networking.vpc_id
  security_group_id = module.security.app_sg_id 
}

module "database" {
  source = "./Storage"
  # Passes the VPC ID from the networking module into the database module
  vpc_id = module.networking.vpc_id 
}

module "edge" {
  source = "./Edge"
  # Passes the VPC ID from the networking module into the edge module
  vpc_id = module.networking.vpc_id 
}
