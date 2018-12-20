provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "~/.aws/config"
  profile                 = "default"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "1.12.0"
  name                   = "rancher"
  instance_count         = "${var.instance_count}"
  ami                    = "ami-ebd02392"
  instance_type          = "t2.medium"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  subnet_id              = "subnet-2345"
  tags = {
    Terraform = "true"
  }
}

resource "aws_lb_target_group" "tg-https" {
  name     = "tg-https"
  port     = "443"
  protocol = "tcp"
  vpc_id   = "${var.vpc_id}"
  target_type = "instance"
  health_check {
     healthy_threshold = 2
     unhealthy_threshold = 2
     timeout = 60
     protocol  = "HTTP"
     interval = 90
     path = "/healthz"
  }
}

resource "aws_lb_target_group" "tg-http" {
  name     = "tg-https"
  port     = "80"
  protocol = "tcp"
  vpc_id   = "${var.vpc_id}"
  target_type = "instance"
  health_check {
     healthy_threshold = 2
     unhealthy_threshold = 2
     timeout = 60
     protocol  = "HTTP"
     interval = 90
     path = "/healthz"
  }
}
