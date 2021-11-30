variable "user_vars" {
    type = "map"
    default = {
    region = "us-east-1"         
    vpc = "vpc-0000000d"
    ami = "ami-0c1bea58988a989155"
    itype = "t2.micro"
    subnet = "subnet-00000c8e"
    publicip = true
    keyname = "myseckey"
    secgroupname = "MY-Sec-Group"
  }
}

provider "aws" {
  region = lookup(var.user_vars, "region")
}

resource "aws_security_group" "new_instance-sg" {
  name = lookup(var.user_vars, "secgroupname")
  description = lookup(var.user_vars, "secgroupname")
  vpc_id = lookup(var.user_vars, "vpc")

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "new_instance" {
  ami = lookup(var.user_vars, "ami")
  instance_type = lookup(var.user_vars, "itype")
  subnet_id = lookup(var.user_vars, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.user_vars, "publicip")
  key_name = lookup(var.user_vars, "keyname")


  vpc_security_group_ids = [
    aws_security_group.new_instance-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="SERVER01"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.new_instance-sg ]
}


output "ec2instance" {
  value = aws_instance.new_instance.public_ip
}
