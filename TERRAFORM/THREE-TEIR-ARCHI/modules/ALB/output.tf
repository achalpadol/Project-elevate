output "alb_id" {
  value = aws_lb.this_alb.id
}
output "alb_arn" {
  value = aws_lb.this_alb.arn
}
output "alb_dns_name" {
  value = aws_lb.this_alb.dns_name
}
output "alb_zone_id" {
  value = aws_lb.this_alb.zone_id
}
output "target_group_arn" {
  value = aws_lb_target_group.this_tg.arn
}
output "listener_arn" {
  value = aws_lb_listener.this_http.arn
}
