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
