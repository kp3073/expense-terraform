resource "aws_instance" "frontend" {
  ami = data.aws_ami.ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags =  {
    name = "frontend"
  }
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
  ami = data.aws_ami.ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags = {
    name = "mysql"
  }
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
  ami = data.aws_ami.ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags = {
    name = "mysql"
  }
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
