output "cluster_id" {
  value = aws_ecs_cluster.this_cluster
}
output "cluster_name" {
  value = aws_ecs_cluster.this_cluster.name
}
output "cluster_arn" {
  value = aws_ecs_cluster.this_cluster.arn
}