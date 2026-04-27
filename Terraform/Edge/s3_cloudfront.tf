resource "aws_s3_bucket" "vocal4local_frontend" {
  bucket = "${var.bucket_name_prefix}-frontend-assets-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "Vocal4Local Frontend"
  }
}

resource "aws_s3_bucket_public_access_block" "vocal4local_frontend" {
  bucket = aws_s3_bucket.vocal4local_frontend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "vocal4local_frontend" {
  bucket = aws_s3_bucket.vocal4local_frontend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "vocal4local_frontend" {
  bucket = aws_s3_bucket.vocal4local_frontend.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_cloudfront_origin_access_control" "vocal4local_oac" {
  name                              = "vocal4local-s3-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "vocal4local_cdn" {
  enabled             = true
  default_root_object = "index.html"
  web_acl_id          = aws_wafv2_web_acl.cloudfront_acl.arn

  # Point to the S3 bucket
  origin {
    domain_name              = aws_s3_bucket.vocal4local_frontend.bucket_regional_domain_name
    origin_id                = "S3-Vocal4Local-Frontend"
    origin_access_control_id = aws_cloudfront_origin_access_control.vocal4local_oac.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-Vocal4Local-Frontend"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = var.enable_custom_domain ? [var.frontend_domain_name] : []

  viewer_certificate {
    cloudfront_default_certificate = !var.enable_custom_domain
    acm_certificate_arn            = var.enable_custom_domain ? var.cloudfront_acm_certificate_arn : null
    ssl_support_method             = var.enable_custom_domain ? "sni-only" : null
    minimum_protocol_version       = var.enable_custom_domain ? "TLSv1.2_2021" : "TLSv1"
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "vocal4local_frontend_policy" {
  statement {
    sid    = "AllowCloudFrontReadOnly"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.vocal4local_frontend.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.vocal4local_cdn.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "vocal4local_frontend" {
  bucket = aws_s3_bucket.vocal4local_frontend.id
  policy = data.aws_iam_policy_document.vocal4local_frontend_policy.json
}

resource "aws_wafv2_web_acl" "cloudfront_acl" {
  provider = aws.us_east_1

  name  = "vocal4local-cloudfront-waf"
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "vocal4local-cloudfront-waf"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-managed-common"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-managed-bad-inputs"
      sampled_requests_enabled   = true
    }
  }
}
