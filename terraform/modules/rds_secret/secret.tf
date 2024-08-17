resource "aws_secretsmanager_secret" "rds_secret" {
  name = "devops/rds_credenciais"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.username_secret
    password = var.password_secret
  })
}