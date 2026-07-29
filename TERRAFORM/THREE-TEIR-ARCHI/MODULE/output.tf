output "instance_id" {
  value = aws_instance.app.id
}

output "private_ip" {
  value = aws_instance.app.private_ip
}

output "availability_zone" {
  value = aws_instance.app.availability_zone
}

output "instance_state" {
  value = aws_instance.app.instance_state
}

output "instance_arn" {
  value = aws_instance.app.arn
}

output "key_name" {
  value = aws_key_pair.deployer.key_name
}

output "private_key_file" {
  value = local_file.private_key.filename
}