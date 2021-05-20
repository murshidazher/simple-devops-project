# Create key using awscli
# aws ec2 create-key-pair --key-name jenkins --query 'KeyMaterial' --output text > jenkins.pem

# EC2 resource

resource "aws_instance" "jenkins-server" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instancetype}"
  key_name               = "jenkins"
  iam_instance_profile   = "${aws_iam_instance_profile.ssm-role.name}" # iam profile is added here
  subnet_id              = "${var.subnetid}"
  vpc_security_group_ids = ["${aws_security_group.jenkinsserver.id}"]

  user_data = "${file("user-data.sh")}"

  tags = {
    Name = "${var.AppName}"
    Env  = "${var.Env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Adding Security Group for our Instance :
resource "aws_security_group" "jenkinsserver" {
  name        = "jenkins-server"
  description = "Jenkins Server Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.HostIp}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.HostIp}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.PvtIp}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
