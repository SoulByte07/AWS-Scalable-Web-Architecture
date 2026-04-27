# Root composition for the full architecture.
#
# Data flow (high level):
# network -> security/compute/database
# security -> compute/database
# edge -> dns (when custom domain is enabled)

module "networking" {
  source = "./Network"
}

# Security groups depend on VPC creation from networking.
module "security" {
  source = "./Security"
  vpc_id = module.networking.vpc_id
}

# Compute layer uses both networking outputs and security group IDs.
module "compute" {
  source                  = "./Compute"
  vpc_id                  = module.networking.vpc_id
  vpc_cidr                = module.networking.vpc_cidr
  private_subnet_ids      = module.networking.private_subnet_ids
  public_subnets          = module.networking.public_subnet_ids
  alb_security_group_id   = module.security.alb_strict_sg_id
  enable_alb_https        = var.enable_alb_https
  alb_acm_certificate_arn = var.alb_acm_certificate_arn
  bucket_name_prefix      = var.bucket_name_prefix
}

# Database runs in private subnets and is reachable only from app SG.
module "database" {
  source               = "./Storage"
  private_db_subnets   = module.networking.private_subnet_ids
  db_security_group_id = module.security.db_sg_id
}

# Edge layer hosts static frontend in S3 + CloudFront (+ WAF).
# CloudFront uses us-east-1 for WAF and ACM compatibility.
module "edge" {
  source = "./Edge"

  bucket_name_prefix             = var.bucket_name_prefix
  enable_custom_domain           = var.enable_custom_domain
  frontend_domain_name           = var.frontend_domain_name
  cloudfront_acm_certificate_arn = var.cloudfront_acm_certificate_arn

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
