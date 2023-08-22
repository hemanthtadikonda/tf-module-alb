locals {
  # sg name
  sg_name = var.internal ? "${var.env}-int-alb-sg" : "${var.env}-pub-alb-sg"
  # lb name
  lb_name = var.internal ? "${var.env}-int-lb" : "${var.env}-pub-lb"
}