variable "aws_access_key"{
    type=string
    sensitive=true

}         # Replace with your AWS access key ID (leave empty if using IAM roles or env vars)
variable "aws_secret_key"{
    sensitive = true
}         # Replace with your AWS secret access key (leave empty if using IAM roles or env vars)
variable "region"{
  default = "us-east-1"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
  default     = "ecommercedb"
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "kurac5user"
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  default     = "kurac5password"
}

variable "default_subnet_id" {
  description = "ID of the public subnet in default VPC"
  type        = string
}

variable "dockerhub_username" {
    sensitive = true

}
variable "dockerhub_password" {
    sensitive = true

}
