resource "aws_security_group" "dart_nginx_sg" {
    vpc_id = aws_vpc.dart_vpc.id
    name = "dart_nginx_sg"
    tags = {
      Name = "dart-nginx_sg"
    }
}

resource "aws_vpc_security_group_egress_rule" "dart_egress_sg_rule" {
  security_group_id = aws_security_group.dart_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
} 

resource "aws_vpc_security_group_ingress_rule" "dart_ingress_80_sg_rule" {
  security_group_id = aws_security_group.dart_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "dart_ingress_22_sg_rule" {
  security_group_id = aws_security_group.dart_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}