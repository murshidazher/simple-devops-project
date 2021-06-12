resource "aws_iam_policy" "docker_jenkins_s3_policy" {
  name        = "docker_jenkins_s3_policy"
  path        = "/"
  description = "s3 policy for Instance "

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "route53:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "docker-s3-pol-attach" {
  role       = aws_iam_role.docker_jenkins_ec2_role.name
  policy_arn = aws_iam_policy.docker_jenkins_s3_policy.arn
}
