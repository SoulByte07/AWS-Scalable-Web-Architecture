data "aws_ssm_parameter" "ami_id" {
  name = var.ami_ssm_parameter
}

locals {
  selected_ami_id = var.ami_id_override != "" ? var.ami_id_override : data.aws_ssm_parameter.ami_id.value
}
