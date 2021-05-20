provider "aws" {
  region = var.region
}

resource "aws_iam_instance_profile" "ssm-role" {
  name = "ssm-role"
  role = "${aws_iam_role.new-ssm-role.name}"
}

resource "aws_iam_role" "new-ssm-role" {
  name = "new-ssm-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2role-ssm-policy-attach" {
  role       = "${aws_iam_role.new-ssm-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "s3-policy-attach" {
  role       = "${aws_iam_role.new-ssm-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ssm-full-policy-attach" {
  role       = "${aws_iam_role.new-ssm-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}
