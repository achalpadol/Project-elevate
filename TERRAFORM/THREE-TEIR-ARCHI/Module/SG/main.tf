resource "aws_security_group" "SG" {
  count       = length(var.sg_name)
  name        = var.sg_name[count.index]
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.sg_name[count.index]
  }
}

# alb ingress
resource "aws_security_group_rule" "alb_ingress" {
  count             = length(var.alb_ports)
  type              = "ingress"
  from_port         = var.alb_ports[count.index]
  to_port           = var.alb_ports[count.index]
  protocol          = var.ingress_protocol
  cidr_blocks       = var.alb_ingress_cidr
  security_group_id = aws_security_group.SG[0].id
}

# alb egress
resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  from_port         = var.egress_from_port
  to_port           = var.egress_to_port
  protocol          = var.egress_protocol
  cidr_blocks       = var.egress_cidr
  security_group_id = aws_security_group.SG[0].id
}

# application ingress
resource "aws_security_group_rule" "app_ingress" {
  count                    = length(var.app_ports)
  type                     = "ingress"
  from_port                = var.app_ports[count.index]
  to_port                  = var.app_ports[count.index]
  protocol                 = var.ingress_protocol
  source_security_group_id = aws_security_group.SG[0].id
  security_group_id        = aws_security_group.SG[1].id
}
# Egress application
resource "aws_security_group_rule" "app_egress" {
  type              = "egress"
  from_port         = var.egress_from_port
  to_port           = var.egress_to_port
  protocol          = var.egress_protocol
  cidr_blocks       = var.egress_cidr
  security_group_id = aws_security_group.SG[1].id
}

# DB ingress
resource "aws_security_group_rule" "db_ingress" {
  count                    = length(var.db_ports)
  type                     = "ingress"
  from_port                = var.db_ports[count.index]
  to_port                  = var.db_ports[count.index]
  protocol                 = var.ingress_protocol
  source_security_group_id = aws_security_group.SG[1].id
  security_group_id        = aws_security_group.SG[2].id
}

# egress db
resource "aws_security_group_rule" "db_egress" {
  type              = "egress"
  from_port         = var.egress_from_port
  to_port           = var.egress_to_port
  protocol          = var.egress_protocol
  cidr_blocks       = var.egress_cidr
  security_group_id = aws_security_group.SG[2].id
}