terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "terraform/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "state-locks" 
    encrypt        = true
  }
}
