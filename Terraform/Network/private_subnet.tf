resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"

  map_public_ip_on_launch = false

  availability_zone = ["ap-south-1a", "ap-south-1b"][count.index]


  tags = {
    Name = "Private Subnet"
  }
}
