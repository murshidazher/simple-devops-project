# Outputs.tf
output "instance_id" {
  description = "docker server instance ID"
  value       = aws_instance.docker.id
}

output "instance_ip" {
  description = "docker server public IP"
  value       = aws_instance.docker.public_ip
}
