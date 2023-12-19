resource "aws_route53_zone" "private_zone" {
  name         = var.name
  comment      = var.comment
 vpc {
    vpc_id = var.vpc_id
  }
  force_destroy = true
}

# we should create records there dynamically

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "sandbox.pandora"
  type    = "A"
  ttl     = 300
  records = ["77.92.107.108"]
}


