resource "aws_lb" "alb" {
  name                       = var.alb_name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = [var.alb_security_group_id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = var.enable_deletion_protection
  tags = {
    Name = var.alb_name
  }
}
resource "aws_lb_target_group" "tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
  health_check {
    path = var.health_check_path
  }
  tags = {
    Name = var.target_group_name
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = var.default_action_type
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
# Target Group Attachment
resource "aws_lb_target_group_attachment" "app_server" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance_id
  port             = var.target_group_port
}