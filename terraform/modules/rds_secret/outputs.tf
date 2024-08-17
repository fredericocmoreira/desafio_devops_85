output "rds_secret_arn" {
  value = aws_secretsmanager_secret.rds_secret.id
}

output "rds_secret_name" {
  value = aws_secretsmanager_secret.rds_secret.name
}

output "rds_endpoint" {
  value = aws_db_instance.devops_rds.endpoint
}
