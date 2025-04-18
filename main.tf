provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myapp_server" {
  ami           = "ami-0c55b159cbfafe1f0"  # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"     # <--- Replace with your actual key pair name

  security_groups = [aws_security_group.myapp_sg.name]

  tags = {
    Name = "MyAppServer"
  }
}

resource "aws_security_group" "myapp_sg" {
  name        = "myapp_sg"
  description = "Allow HTTP and Kubernetes access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
