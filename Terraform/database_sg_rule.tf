resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
  security_group_id            = module.security.db_sg_id
  referenced_security_group_id = module.compute.app_sg_id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  description                  = "Allow MySQL only from app security group"
}
