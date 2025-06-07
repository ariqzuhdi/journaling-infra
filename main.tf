provider "aws" {
  region  = var.aws_region
  profile = var.profile
}

resource "aws_instance" "journaling-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.journaling_sg.id]

  tags = {
    Name = var.instance_tag
  }
}

