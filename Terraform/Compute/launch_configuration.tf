resource "aws_launch_configuration" "launch_configuration" {
  name          = "web_config"
  image_id      = data.var.aws_ami
  instance_type = var.intance_type
}
