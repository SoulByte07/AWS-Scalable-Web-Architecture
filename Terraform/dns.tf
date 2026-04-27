# Optional DNS wiring for custom domain support.
# Resources are skipped unless enable_custom_domain=true.
data "aws_route53_zone" "primary" {
  count = var.enable_custom_domain ? 1 : 0

  name         = var.root_domain_name
  private_zone = false
}

resource "aws_route53_record" "frontend_alias" {
  count = var.enable_custom_domain ? 1 : 0

  zone_id = data.aws_route53_zone.primary[0].zone_id
  name    = var.frontend_domain_name
  type    = "A"

  alias {
    # Route53 alias points directly to CloudFront distribution.
    name                   = module.edge.cloudfront_domain_name
    zone_id                = module.edge.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}
