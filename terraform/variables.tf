variable "bloco_cidr" {
  type        = string
  description = "Bloco CIDR de rede a ser usado para o VPC"
  default     = "10.0.0.0/16"
}

variable "username_secret" {
  type    = string
  default = "teste"
}

variable "password_secret" {
  type    = string
  default = "testado321"
}

variable "name_db_rds" {
  type    = string
  default = "wordpress_db"
}