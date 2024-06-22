resource "aws_instance" "frontend" {
  ami = local.ami
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags =  {
    name = "frontend"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z03008653NMBFHGJP7YNJ"
  name    = "frontend.aligntune.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}
resource "null_resource" "frontend" {
  depends_on = [ aws_instance.frontend ]
  provisioner "local-exec" {
    command = <<EOF
    cd /root/Expense-ansible
    git pull
    sleep 60
    ansible-playbook -i ${aws_instance.frontend.private_ip}, -e ansible_username=centos -e ansible_password=DevOps321 main.yml -e role_name=frontend
    EOF
  }
}


resource "aws_instance" "mysql" {
  ami = local.ami
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags = {
    name = "mysql"
  }
}



resource "aws_route53_record" "mysql" {
  zone_id = "Z03008653NMBFHGJP7YNJ"
  name    = "mysql.aligntune.online"
  type    = "A"
  ttl     = 300
  records = [ aws_instance.mysql.private_ip ]
}

resource "null_resource" "mysql" {
  depends_on = [ aws_instance.mysql ]
  provisioner "local-exec" {
    command = <<EOF
    cd /root/Expense-ansible
    git pull
    sleep 60
    ansible-playbook -i ${aws_instance.mysql.private_ip}, -e ansible_username=centos -e ansible_password=DevOps321 main.yml -e role_name=mysql
    EOF
  }
}

resource "aws_instance" "backend" {
  ami = local.ami
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags = {
    name = "backend"
  }
}


resource "aws_route53_record" "backend" {
  zone_id = "Z03008653NMBFHGJP7YNJ"
  name    = "backend.aligntune.online"
  type    = "A"
  ttl     = 300
  records = [ aws_instance.backend.private_ip ]
}

resource "null_resource" "backend" {
  depends_on = [ aws_instance.backend ]
  provisioner "local-exec" {
    command = <<EOF
    cd /root/Expense-ansible
    git pull
    sleep 60
    ansible-playbook -i ${aws_instance.backend.private_ip}, -e ansible_username=centos -e ansible_password=DevOps321 main.yml -e role_name=backend
    EOF
  }
}
