
resource "aws_security_group" "sg" {
  name        = "${var.env}-alb-sg"
  description = "${var.env}-alb-sg"
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { Name = local.sg_name})

  ingress {
    description      = "App"
    from_port        = var.sg_port
    to_port          = var.sg_port
    protocol         = "tcp"
    cidr_blocks      = var.sg_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_lb" "alb" {
  name               = "${var.env}-alb"
  internal           = var.internal
  load_balancer_type = var.lb_type
  security_groups    = aws_security_group.sg.id
  subnets            = var.subnets
  tags               = merge ( var.tags, { Name= local.lb_name }
}