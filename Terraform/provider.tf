terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Primary region for most resources in this project.
provider "aws" {
  region = "ap-south-1" # mumbai
}

# Secondary region alias required for global edge integrations.
# CloudFront custom-domain ACM certificates and WAF (CLOUDFRONT scope)
# are managed in us-east-1.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
