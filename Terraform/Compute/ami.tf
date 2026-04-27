# Resolve latest Amazon Linux AMI from SSM Parameter Store by default.
data "aws_ssm_parameter" "ami_id" {
  name = var.ami_ssm_parameter
}

locals {
  # Allow manual AMI pinning for experiments via ami_id_override.
  selected_ami_id = var.ami_id_override != "" ? var.ami_id_override : data.aws_ssm_parameter.ami_id.value
}
