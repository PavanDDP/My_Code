resource "aws_security_group" "webserver-SG" {
  name        = "webserver-SG"
  description = "Allow SSH and HTTP ports"

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver-SG"
  }
}

resource "aws_instance" "Maven" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = var.keyname
  vpc_security_group_ids = [aws_security_group.webserver-SG.id]
  user_data              = file("Maven_user_data.sh")
  tags                   = var.webservertag
}