resource "aws_instance" "frontend" {
  ami = data.aws_ami.ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  tags =  {
    name = "frontend"
  }

  provisioner "local-exec" {
    command = <<EOF
    cd /root/Expense-ansible
    git pull
    sleep 60
    ansible-playbook -i ${self.private_ip}, -e ansible_username=centos -e ansible_password=DevOps321 expense.yml -e role_name=frontend
    EOF
  }
}


# resource "aws_instance" "backend" {
#   ami = data.aws_ami.ami.id
#   instance_type = "t3.micro"
#   vpc_security_group_ids = [data.aws_security_group.sg.id]
#   tags = {
#     name = "backend"
#   }
# }


# resource "aws_instance" "mysql" {
#   ami = data.aws_ami.ami.id
#   instance_type = "t3.micro"
#   vpc_security_group_ids = [data.aws_security_group.sg.id]
#   tags = {
#     name = "mysql"
#   }
# }
