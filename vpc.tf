provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "nicolas_vpc" {
  cidr_block = "172.13.0.0/16"
  tags = {
    Name = "nicolas-vpc"
  }
}

resource "aws_subnet" "nicolas_priv01" {
  vpc_id = aws_vpc.nicolas_vpc.id
  cidr_block = "172.13.1.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "nicolas_priv01"
  }
}
resource "aws_subnet" "nicolas_priv02" {
  vpc_id = aws_vpc.nicolas_vpc.id
  cidr_block = "172.13.2.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "nicolas_priv02"
  }
}
resource "aws_subnet" "nicolas_pub01" {
  vpc_id = aws_vpc.nicolas_vpc.id
  cidr_block = "172.13.3.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "nicolas_pub01"
  }
}
resource "aws_subnet" "nicolas_pub02" {
  vpc_id = aws_vpc.nicolas_vpc.id
  cidr_block = "172.13.4.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "nicolas_pub02"
  }
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nicolas_vpc.id
  tags = {
    Name = "nicolas-igw" 
  }
}

resource "aws_route_table" "route_pub" {
  vpc_id = aws_vpc.nicolas_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "nicolas-routetable"
  }
}

resource "aws_route_table_association" "pub01assoc" {
  subnet_id = aws_subnet.nicolas_pub01.id
  route_table_id = aws_route_table.route_pub.id
}
resource "aws_route_table_association" "pub02assoc" {
  subnet_id = aws_subnet.nicolas_pub02.id
  route_table_id = aws_route_table.route_pub.id
}