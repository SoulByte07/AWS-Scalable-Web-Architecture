# Network/public_subnet.tf
resource "aws_subnet" "public_subnet" {
  count             = length(var.availability_zones) # Loops twice
  vpc_id            = aws_vpc.main_vpc.id
  
  # Generates 10.0.1.0/24 and 10.0.2.0/24
  cidr_block        = "10.0.${count.index + 1}.0/24" 
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true 

  tags = {
    Name = "Public Subnet ${var.availability_zones[count.index]}"
  }
}
