variable "instance_type"{
    default = "t3.micro"
}   

variable "vpc_id" {
  
}
variable "default_vpc_id" {
  
}
variable "private_subnet_id" {
  
}
variable "public_subnet_id" {
  
}
variable "default_subnet_id" {

}
variable "lb_sg_id" {

}

variable "dockerhub_username" {
    sensitive = true

}
variable "dockerhub_password" {
    sensitive = true

}
variable "db_instance" {
  
}

variable "nat_gateway" {
  
}

