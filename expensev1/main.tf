resource "aws_instance" "frontend" {
  ami = data.aws_ami.ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]


}


resource "aws_instance" "backend" {
  ami = data.aws_ami.ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]


}


resource "aws_instance" "mysql" {
  ami = data.aws_ami.ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
}
