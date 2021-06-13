resource "aws_route53_zone" "private" {
  name = var.domain_name
}

resource "aws_route53_record" "webserver" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "web.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.kube.private_ip}"]
}
