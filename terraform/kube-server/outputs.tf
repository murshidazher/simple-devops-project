# Outputs.tf
output "instance_id" {
  description = "kube server instance ID"
  value       = aws_instance.kube.id
}

output "instance_ip" {
  description = "kube server public IP"
  value       = aws_instance.kube.public_ip
}
