resource "aws_security_group" "this_SG" {
  count       = length(var.SG_NAME)
  name        = var.SG_NAME[count.index]
  description = "Security Group for ALB"
  vpc_id      = var.VPC_ID
  tags = {
    Name = var.SG_NAME[count.index]
  }
}
# alb ingress
resource "aws_security_group_rule" "this_alb_ingress" {
  count             = length(var.ALB_PORTS)
  type              = "ingress"
  from_port         = var.ALB_PORTS[count.index]
  to_port           = var.ALB_PORTS[count.index]
  protocol          = var.INGRESS_PROTOCOL
  cidr_blocks       = var.ALB_INGRESS_CIDR
  security_group_id = aws_security_group.this_SG[0].id
}
# alb egress
resource "aws_security_group_rule" "this_alb_egress" {
  type              = "egress"
  from_port         = var.EGRESS_FROM_PORT
  to_port           = var.EGRESS_TO_PORT
  protocol          = var.EGRESS_PROTOCOL
  cidr_blocks       = var.EGRESS_CIDR
  security_group_id = aws_security_group.this_SG[0].id
}
# application ingress
resource "aws_security_group_rule" "this_app_ingress" {
  count                    = length(var.APP_PORTS)
  type                     = "ingress"
  from_port                = var.APP_PORTS[count.index]
  to_port                  = var.APP_PORTS[count.index]
  protocol                 = var.INGRESS_PROTOCOL
  source_security_group_id = aws_security_group.this_SG[0].id
  security_group_id        = aws_security_group.this_SG[1].id
}
# Egress application
resource "aws_security_group_rule" "this_app_egress" {
  type              = "egress"
  from_port         = var.EGRESS_FROM_PORT
  to_port           = var.EGRESS_TO_PORT
  protocol          = var.EGRESS_PROTOCOL
  cidr_blocks       = var.EGRESS_CIDR
  security_group_id = aws_security_group.this_SG[1].id
}
# DB ingress
resource "aws_security_group_rule" "db_ingress" {
  count                    = length(var.DB_PORTS)
  type                     = "ingress"
  from_port                = var.DB_PORTS[count.index]
  to_port                  = var.DB_PORTS[count.index]
  protocol                 = var.INGRESS_PROTOCOL
  source_security_group_id = aws_security_group.this_SG[1].id
  security_group_id        = aws_security_group.this_SG[2].id
}
# egress db
resource "aws_security_group_rule" "this_db_egress" {
  type              = "egress"
  from_port         = var.EGRESS_FROM_PORT
  to_port           = var.EGRESS_TO_PORT
  protocol          = var.EGRESS_PROTOCOL
  cidr_blocks       = var.EGRESS_CIDR
  security_group_id = aws_security_group.this_SG[2].id
}