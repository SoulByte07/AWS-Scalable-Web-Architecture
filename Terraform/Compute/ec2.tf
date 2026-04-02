resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_ids[0]
  security_groups = ["aws_security_group.web_sg.id"]
  autoscaling_group = "aws_autoscaling_group.web_asg.name"

  tags = {
    Name = "WebServer"
  }
}
