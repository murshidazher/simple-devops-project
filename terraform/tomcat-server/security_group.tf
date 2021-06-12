locals {
  jenkins_ip = "${data.terraform_remote_state.jenkins_server.outputs.instance_ip}/32"
}

# access the previously created security group from remote state
data "terraform_remote_state" "jenkins_server" {
  backend = "s3"
  config = {
    bucket = "javahome-tf-1212"
    key    = "deploy-jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_security_group" "allow_jenkins_tomcat" {
  description = "Allow jenkins traffic"
  ingress {
    description = "allow ssh to system"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.mysystem, local.jenkins_ip]
  }
  ingress {
    description = "allow ssh to system"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # add the webhook ips and whitelist them
    cidr_blocks = [var.mysystem, local.jenkins_ip]
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
