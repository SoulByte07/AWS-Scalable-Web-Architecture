resource "aws_s3_bucket" "vocal4local_frontend" {
  bucket = "vocal4local-frontend-assets"

  tags = {
    Name = "Vocal4Local Frontend"
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

  viewer_certificate {
    cloudfront_default_certificate = true # TODO :We will upgrade to ACM later
  }
}

