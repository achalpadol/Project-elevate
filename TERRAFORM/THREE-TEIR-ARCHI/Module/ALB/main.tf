resource "aws_lb" "alb" {

  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.alb_security_group_id]
  subnets         = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "tg" {

  name     = var.target_group_name
  port     = var.target_group_port
  protocol = "HTTP"

  vpc_id = var.vpc_id

  health_check {
    path = "/"
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.alb.arn

  port     = var.listener_port
  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.tg.arn
  }
}