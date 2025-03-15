output "main_vpc_id" {
  value       = aws_vpc.jsbase_main_vpc.id
  description = "vpc id of the main vpc"
}

output "main_subnet_id" {
  value       = aws_subnet.jsbase_main_subnet.id
  description = "subnet id of the main subnet"
}

output "main_igw" {
  value       = aws_internet_gateway.jsbase_main_igw.id
  description = "internet gateway id of the main vpc"
}

output "main_route_table" {
  value       = aws_route_table.jsbase_main_route_table.id
  description = "route table id of the main vpc"
}

output "main_route_table_association" {
  value       = aws_main_route_table_association.jsbase_main_route_table_association.id
  description = "route table association id of the main vpc"
}
