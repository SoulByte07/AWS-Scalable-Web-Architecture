resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = "aws_subnet.private_subnet.id"
  security_groups = ["aws_security_group.web_sg.id"]
  autoscaling_group = "aws_autoscaling_group.web_asg.name"

  tags = {
    Name = "WebServer"
  }
}
