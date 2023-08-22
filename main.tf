
resource "aws_security_group" "sg" {
  name        = "${var.env}-alb-sg"
  description = "${var.env}-alb-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "App"
    from_port        = var.sg_port
    to_port          = var.sg_port
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}






resource "aws_lb" "alb" {
  name               = "${var.env}-alb"
  internal           = var.internal
  load_balancer_type = var.lb_type
  security_groups    =
  subnets            = []

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}