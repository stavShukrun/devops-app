output "output_vpc_id" {
  description = "vpc ID"
  value       = aws_vpc.stav-terraform-vpc.id
}

output "private_subnet_1_id" {
  description = "private subnet 1 ID"
  value       = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  description = "private subnet 2 ID"
  value       = aws_subnet.private_subnet_2.id
}

output "public_subnet_1_id" {
  description = "public subnet 1 ID"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "public subnet 2 ID"
  value       = aws_subnet.public_subnet_2.id
}