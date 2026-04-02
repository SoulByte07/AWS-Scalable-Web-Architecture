# 1. Allocate a static Public IP for the NAT Gateway
resource "aws_eip" "vocal4local_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "Vocal4Local NAT EIP"
  }
}

# 2. Create the NAT Gateway in the Public Subnet
resource "aws_nat_gateway" "vocal4local_nat" {
  allocation_id = aws_eip.vocal4local_nat_eip.id
  subnet_id     = var.public_subnet_az1 

  tags = {
    Name = "Vocal4Local Primary NAT"
  }

  # Ensure the Internet Gateway is created before the NAT Gateway
  # Replace 'aws_internet_gateway.your_existing_igw' with your actual IGW resource name
  depends_on = [aws_internet_gateway.your_existing_igw] 
}

# 3. Create a Route Table for your Private Subnets
resource "aws_route_table" "vocal4local_private_rt" {
  vpc_id = var.vpc_id

  # Send all outside traffic to the NAT Gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vocal4local_nat.id
  }

  tags = {
    Name = "Vocal4Local Private Route Table"
  }
}

# 4. Associate the Route Table with your Private Subnets
resource "aws_route_table_association" "private_az1_assoc" {
  subnet_id      = var.private_subnet_az1
  route_table_id = aws_route_table.vocal4local_private_rt.id
}

