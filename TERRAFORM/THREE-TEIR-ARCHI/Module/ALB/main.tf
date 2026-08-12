resource "aws_lb" "this_alb" {
  name                       = var.ALB_NAME
  internal                   = var.INTERNAL
  load_balancer_type         = var.LOAD_BALANCER_TYPE
  security_groups            = [var.ALB_SECURITY_GROUP_ID]
  subnets                    = var.PUBLIC_SUBNET_IDS
  enable_deletion_protection = var.ENABLE_DELETION_PROTECTION
  tags = {
    Name = var.ALB_NAME
  }
}
resource "aws_lb_target_group" "this_tg" {
  name     = var.TARGET_GROUP_NAME
  port     = var.TARGET_GROUP_PORT
  protocol = var.TARGET_GROUP_PROTOCOL
  vpc_id   = var.VPC_ID
  target_type = VAR.INSTANCE.ID
   health_check {
    path                = var.HEALTH_CHECK_PATH
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
  tags = {
    Name = var.TARGET_GROUP_NAME
  }
}
resource "aws_lb_listener" "this_http" {
  load_balancer_arn = aws_lb.this_alb.arn
  port              = var.LISTENER_PORT
  protocol          = var.LISTENER_PROTOCOL
  default_action {
    type             = var.DEFAULT_ACTION_TYPE
    target_group_arn = aws_lb_target_group.this_tg.arn
  }
}
# Target Group Attachment
#resource "aws_lb_target_group_attachment" "this_app_server" {
  #target_id        = var.INSTANCE_ID
  #port             = var.TARGET_GROUP_PORT
#}
