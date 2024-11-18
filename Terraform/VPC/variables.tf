variable "app_instance_id" {
  
}
variable "default_vpc_id" {
  description = "ID of the default VPC"
  type        = string
}

variable "default_subnet_id" {
  description = "ID of the public subnet in default VPC"
  type        = string
}

variable "default_route_table_id" {
  description = "ID of the main route table in default VPC"
  type        = string
}


