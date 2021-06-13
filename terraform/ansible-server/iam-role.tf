resource "aws_iam_role" "ansible_jenkins_ec2_role" {
  name = "ansible_jenkins_ec2_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "ec2-role"
  }
}



resource "aws_iam_instance_profile" "ansible_jenkins_ec2_profile" {
  name = "ansible_jenkins_ec2_profile"
  role = aws_iam_role.ansible_jenkins_ec2_role.name
}
