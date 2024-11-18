output "app_sg_id" {
  value = aws_security_group.app_sg.id
}

output "app_instance_ids" {
  value = [aws_instance.ecommerce_app_az1.id, aws_instance.ecommerce_app_az2.id]
}