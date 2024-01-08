provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "demo" {
    ami = "ami-0a0f1259dd1c90938"
    instance_type = "t2.micro"
    key_name = "abc.pem"
    security_groups = [ "demo-sg" ]
}

resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "ssh-acces"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-port"
  }
}

# create vpc
resource "aws_vpc" "dpp-vpc" {
  cidr_block = "10.1.0.0/16" 
  tags = {
    name = "dpp-vpc"
  }
  
}
resource "aws_subnet" "dpp-public-subnet-01"{
  vpc_id = aws_vpc.dpp-vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "ap-south-1"
  
}