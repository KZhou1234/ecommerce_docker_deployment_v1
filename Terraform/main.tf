#- 1x Custom VPC named "wl5vpc" in us-east-1
provider "aws" {
  access_key =  var.aws_access_key         # Replace with your AWS access key ID (leave empty if using IAM roles or env vars)
  secret_key =  var.aws_secret_key        # Replace with your AWS secret access key (leave empty if using IAM roles or env vars)
  region     =  var.region          # Specify the AWS region where resources will be created (e.g., us-east-1, us-west-2)
}
# default vpc
data "aws_vpc" "default" {
  default = true
}
data "aws_subnet" "default_subnet" {
  id = var.default_subnet_id
}

#default security group
data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "group-name"
    values = ["Jenkins"]
  }
}

#main route table for default VPC
data "aws_route_table" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "association.main"
    values = ["true"]
  }
}
module "VPC" {
  source = "./VPC"
  app_instance_id = module.EC2.app_instance_ids
  default_route_table_id = data.aws_route_table.default.id
  default_vpc_id = data.aws_vpc.default.id
  default_subnet_id = data.aws_subnet.default_subnet.id
}

module "EC2" {
  source = "./EC2"
  #get output from VPC, use them in EC2
  default_vpc_id = module.VPC.default_vpc_id
  default_subnet_id = module.VPC.default_subnet_id
  vpc_id = module.VPC.vpc_id
  private_subnet_id = module.VPC.private_subnet_ids
  public_subnet_id = module.VPC.public_subnet_ids
  lb_sg_id = module.VPC.lb_sg_id
  nat_gateway = module.VPC.nat_gateway
  dockerhub_username = var.dockerhub_username  
  dockerhub_password = var.dockerhub_password
  db_instance = aws_db_instance.main


}


resource "aws_db_instance" "main" {
  identifier           = "ecommerce-db"
  engine               = "postgres"
  engine_version       = "14.13"
  instance_class       = var.db_instance_class
  allocated_storage    = 20
  storage_type         = "standard"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres14"
  skip_final_snapshot  = true
  
  # the subnet group is created below and the subnet used is the private subnet
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  #the security group here also is using the created backend sg
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "Ecommerce main"
  }
}
# in aws, there are two types of subnet, and security group, one for data resource and one for resource
# following are data, so we need to connect with the resource
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = module.VPC.private_subnet_ids

  tags = {
    Name = "RDS subnet group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Security group for RDS"
  vpc_id      = module.VPC.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.EC2.app_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}




#- A load balancer that will direct the inbound traffic to either of the public subnets.
#- An RDS databse (See next step for more details)
