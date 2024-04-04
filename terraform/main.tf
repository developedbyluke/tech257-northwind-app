provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Allows traffic on port 5000"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Allows traffic on port 3306"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
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

resource "aws_instance" "app_instance" {
  tags = {
    Name = "tech257-group-1-app"
  }
  ami             = "ami-123456"
  instance_type   = "t2.micro"
  key_name        = "tech257"
  security_groups = ["app_sg"]
}

resource "aws_instance" "db_instance" {
  tags = {
    Name = "tech257-group-1-db"
  }
  ami             = "ami-123456"
  instance_type   = "t2.micro"
  key_name        = "tech257"
  security_groups = ["db_sg"]
}

output "app_public_ip" {
  value = data.aws_instance.app_instance.public_ip
}

output "db_private_ip" {
  value = data.aws_instance.db_instance.private_ip
}
