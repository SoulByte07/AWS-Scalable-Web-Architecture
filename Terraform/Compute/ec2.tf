terraform "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = "aws_subnet.private_subnet.id"
  security_groups = ["aws_security_group.web_sg.id"]
  autoscaling_group = "aws_autoscaling_group.web_asg.name"

  tags = {
    Name = "WebServer"
  }
}
