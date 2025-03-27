data "aws_ami" "imagem_ec2" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

resource "aws_network_interface" "dart_nginx_ei" {
  subnet_id = aws_subnet.sn_pub01.id
  tags = {
    Name = "dart_nginx_ei"
  }
}

resource "aws_instance" "dart_nginx_ec2" {
  instance_type = "t3.micro"
  ami = data.aws_ami.imagem_ec2.id
  vpc_security_group_ids = [ aws_security_group.dart_nginx_sg.id ]
  
  network_interface {
    network_interface_id = aws_network_interface.dart_nginx_ei.id
    device_index = 0
  }
  associate_public_ip_address = true
  tags = {
    Name = "dart-nginx_ec2"
  }
}