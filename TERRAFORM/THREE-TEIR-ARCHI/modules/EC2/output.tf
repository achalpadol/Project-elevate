output "instance_id" {
  value = aws_instance.this_app.id
}
output "private_ip" {
  value = aws_instance.this_app.private_ip
}
output "availability_zone" {
  value = aws_instance.this_app.availability_zone
}
output "instance_state" {
  value = aws_instance.this_app.instance_state
}
output "instance_arn" {
  value = aws_instance.this_app.arn
}
output "key_name" {
  value = aws_key_pair.this_deployer.key_name
}
output "private_key_file" {
  value = local_file.this_private_key.filename
}
