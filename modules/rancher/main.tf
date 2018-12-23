provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "~/.aws/config"
  profile                 = "default"
}

data "aws_subnet_ids" "selected" {
  vpc_id      = "${var.vpc_id}"
  tags = {
    Tier = "Private"
  }
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

resource "aws_instance" "ec2-rancher" {
  count                  = "${var.instance_count}"
  ami                    = "ami-0ac019f4fcb7cb7e6"
  instance_type          = "t2.medium"
  key_name               = "shant1"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.selected.ids, count.index)}"
  tags = {
    Terraform = "true"
  }
}

resource "aws_lb_target_group" "tg-https" {
  name     = "tg-https"
  port     = "443"
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
  target_type = "instance"
  health_check {
     healthy_threshold = 2
     unhealthy_threshold = 2
     protocol  = "HTTP"
     interval = 30
     path = "/healthz"
  }
}

resource "aws_lb_target_group" "tg-http" {
  name     = "tg-http"
  port     = "80"
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
  target_type = "instance"
  health_check {
     healthy_threshold = 2
     unhealthy_threshold = 2
     protocol  = "HTTP"
     interval = 30
     path = "/healthz"
  }
}
