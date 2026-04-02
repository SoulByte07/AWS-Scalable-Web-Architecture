# File: Network/outputs.tf
# Description: Exports the VPC and Subnet IDs so other modules can use them.

output "vpc_id" {
  value = aws_vpc.main.id # Ensure this matches your actual VPC resource name
}

output "public_subnet_id" {
  value = aws_subnet.public.id # Ensure this matches your public subnet resource name
}
