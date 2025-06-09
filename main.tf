provider "aws" {
  region  = var.aws_region
  profile = var.profile
}

resource "aws_instance" "journaling-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    apt install -y amazon-cloudwatch-agent

    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
      -a fetch-config \
      -m ec2 \
      -c ssm:AmazonCloudWatch-linux \
      -s
  EOF

  vpc_security_group_ids = [aws_security_group.journaling_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.journaling_profile.name

  tags = {
    Name = var.instance_tag
  }
}

resource "aws_iam_instance_profile" "journaling_instance_profile" {
  name = "journaling_instance_profile"
  role = aws_iam_role.cloudwatch_ec2_role.name
}

resource "aws_eip" "journaling_eip" {
  instance = aws_instance.journaling-instance.id
}

resource "aws_ssm_parameter" "cloudwatch_agent_config" {
  name  = "/journaling/cloudwatch/agent/config"
  type  = "String"
  value = jsonencode(file("/policies/cloudwatch-agent-config.json"))
}
