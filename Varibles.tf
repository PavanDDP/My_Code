variable "region" {
  type    = string
  default = "us-east-1"
}

// Image Name (Amezon Linux 2)
variable "image_id" {
  type    = string
  default = "ami-0195204d5dce06d99"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "keyname" {
  type    = string
  default = "terraform"
}

variable "ssh_port" {
  type    = string
  default = "22"
}

variable "http_port" {
  type    = string
  default = "80"
}

variable "ports" {
  type    = list(any)
  default = [22, 80]
}


variable "webservertag" {
  type = map(any)
  default = {
    Name = "Appache",
    Env  = "Dev"
  }
}

output "Maven_Server_Public_IP" {
  value = aws_instance.Maven.public_ip
}

