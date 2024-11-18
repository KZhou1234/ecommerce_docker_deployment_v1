output "vpc_id" {
  
  value = aws_vpc.wl6vpc.id
  #when the vpc module get created, output the vpc id
}

#output both private subnet ids 
output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}
#output both public subnet ids 
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "default_subnet_id" {
  value = data.aws_subnet.default_subnet.id
}
output "aws_route_table_id" {
  value = data.aws_route_table.default.id
}

output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}

output "nat_gateway" {
  value = aws_nat_gateway.nat_gateway[*]
  
}