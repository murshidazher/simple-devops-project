resource "aws_instance" "jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.allow_login.id]
  tags = {
    Name = var.project
    OS   = var.os
  }
  user_data = file("user-data.sh")
}
