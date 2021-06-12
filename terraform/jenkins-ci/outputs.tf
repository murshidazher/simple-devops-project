# Outputs.tf
output "instance_id" {
  description = " Instance ID of the instance"
  value       = aws_instance.jenkins.id
}

output "instance_ip" {
  description = " Public IP of the instance"
  value       = aws_instance.jenkins.public_ip
}

output "allow_login_id" {
  description = "output allow login security group id"
  value       = ["${aws_security_group.allow_login.id}"]
  # sensitive = true
}
