resource "aws_eip" "this" {
  count = var.create_elastic_ip ? 1 : 0

  vpc = true
}
