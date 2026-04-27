# One EIP + NAT gateway per AZ for HA private egress.
resource "aws_eip" "nat_eip" {
  count = length(var.availability_zones)

  domain = "vpc"

  tags = {
    Name = "vocal4local-nat-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count = length(var.availability_zones)

  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "vocal4local-nat-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Private route tables send default traffic through NAT, not IGW.
resource "aws_route_table" "private_rt" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "vocal4local-private-rt-${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}
