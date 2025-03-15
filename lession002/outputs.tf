output "main_vpc_id" {
  value       = aws_vpc.jsbase_main_vpc.id
  description = "vpc id of the main vpc"
}

output "main_subnet_id" {
  value       = aws_subnet.jsbase_main_subnet.id
  description = "subnet id of the main subnet"
}

output "main_igw_id" {
  value       = aws_internet_gateway.jsbase_main_igw.id
  description = "internet gateway id of the main vpc"
}

output "main_route_table_id" {
  value       = aws_route_table.jsbase_main_route_table.id
  description = "route table id of the main vpc"
}

output "main_route_table_association_id" {
  value       = aws_main_route_table_association.jsbase_main_route_table_association.id
  description = "route table association id of the main vpc"
}

output "main_ec2_id" {
  value       = aws_instance.jsbase_main_ec2[0].id
  description = "value of the main ec2 instance id"
}

output "main_ec2_arn" {
  value       = aws_instance.jsbase_main_ec2[0].arn
  description = "value of the main ec2 instance arn"
}

output "main_eip" {
  value       = aws_eip.jsbase_main_eip.public_ip
  description = "value of the main eip"
}

output "main_security_group_id" {
  value       = aws_security_group.jsbase_main_sg.id
  description = "security group id of the main vpc"

}
