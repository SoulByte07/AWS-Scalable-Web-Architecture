# Network/private_subnet.tf
resource "aws_subnet" "private_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main_vpc.id
  
  # Generates 10.0.3.0/24 and 10.0.4.0/24
  cidr_block        = "10.0.${count.index + 3}.0/24" 
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet ${var.availability_zones[count.index]}"
  }
}
