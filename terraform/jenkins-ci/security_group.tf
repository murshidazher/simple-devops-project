resource "aws_security_group" "allow_login" {
  description = "Allow  inbound traffic"

  ingress {
    description = "allow ssh to system"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.mysystem]
  }
  ingress {
    description = "allow ssh to system"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # add the webhook ips and whitelist them
    cidr_blocks = [var.mysystem, "192.30.252.0/22", "185.199.108.0/22", "140.82.112.0/20"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
