# Outputs.tf
output "instance_id" {
  description = "Tomcat server instance ID"
  value       = aws_instance.tomcat.id
}

output "instance_ip" {
  description = "Tomcat server public IP"
  value       = aws_instance.tomcat.public_ip
}
