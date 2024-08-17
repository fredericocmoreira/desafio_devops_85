variable "tags" {
  type        = map(any)
  description = "Tags a serem adicionadas aos recursos da AWS"
}

variable "vpc_rds_devops" {
  type        = string
  description = "VPC RDS"
}

variable "private_subnet_rds_1a" {
  type        = string
  description = "ID subnet privada AZ 1a"
}

variable "private_subnet_rds_1b" {
  type        = string
  description = "ID subnet privada AZ 1b"
}

variable "username_secret" {
  type = string
}

variable "password_secret" {
  type = string
}

variable "name_db_rds" {
  type = string
}