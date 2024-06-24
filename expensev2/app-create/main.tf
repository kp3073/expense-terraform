resource "aws_instance" "instance" {
  ami = local.ami
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags =  {
    name = var.componant
  }
}

resource "aws_route53_record" "record" {
  zone_id = "Z03008653NMBFHGJP7YNJ"
  name    = "${var.componant}.aligntune.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.instance.private_ip]
}
resource "null_resource" "ansible" {
  depends_on = [ aws_instance.instance ]
  provisioner "local-exec" {
    command = <<EOF
    cd /root/Expense-ansible
    git pull
    sleep 60
    ansible-playbook -i ${aws_instance.instance.private_ip}, -e ansible_username=centos -e ansible_password=DevOps321 main.yml -e role_name=${var.componant}
    EOF
  }
}