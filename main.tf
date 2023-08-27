
resource "aws_security_group" "main" {
  name        = local.sg_name
  description = local.sg_name
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


resource "aws_lb" "main" {
  name               = local.lb_name
  internal           = var.internal
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.main.id]
  subnets            = var.subnets
  tags               = merge ( var.tags , { Name= local.lb_name } )
}