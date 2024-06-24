data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]

  }

  data "aws_security_group" "sg" {
  name = "allow-all"
}

locals {
  ami = data.aws_ami.ami.id
}

data "aws_route53_zone" "zone" {
  zone_id = "Z03008653NMBFHGJP7YNJ"
}

locals {
  zone_id = data.aws_route53_zone.zone
}