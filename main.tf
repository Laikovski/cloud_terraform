resource "aws_instance" "remote-host" {

  ami                     = var.ami_id
  instance_type           = "t2.micro"
  key_name                = var.key_name
  monitoring              = true
  vpc_security_group_ids  = [aws_security_group.security_ec2_instance.id]
  availability_zone       = "eu-central-1b"
  iam_instance_profile    = "ec2-access"
  user_data               = <<EOF
      #! bin/bash
      sudo mkdir /data-f
      sudo mkfs -t xfs /dev/xvdf
      sudo mount /dev/xvdf /data-f
	EOF
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_size = 2
    volume_type = "gp2"
  }

  tags = var.tag-ec2
}

resource "aws_security_group" "security_ec2_instance" {
  name                  = "security_group_remote_host"

  ingress {
    from_port = 8080
    protocol  = "tcp"
    to_port   = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port = 443
    protocol  = "tcp"
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "security_jenkins_port"
  }
}