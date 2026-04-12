# File: Network/outputs.tf
# Description: Exports the VPC and Subnet IDs so other modules can use them.

output "vpc_id" {
  value = aws_vpc.main_vpc.id 
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet[count.index]
}
