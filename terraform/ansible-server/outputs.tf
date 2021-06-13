# Outputs.tf
output "instance_id" {
  description = "ansible server instance ID"
  value       = aws_instance.ansible.id
}

output "instance_ip" {
  description = "ansible server public IP"
  value       = aws_instance.ansible.public_ip
}
