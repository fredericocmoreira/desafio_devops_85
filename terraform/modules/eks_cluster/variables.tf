variable "kubernetes_version" {
  type    = string
  default = "1.30"
}

variable "tags" {
  type        = map(any)
  description = "Tags a serem adicionadas aos recursos da AWS"
}

variable "public_subnet_1a" {
  type        = string
  description = "Subnet criação cluster EKS AZ 1a"
}

variable "public_subnet_1b" {
  type        = string
  description = "Subnet criação cluster EKS AZ 1b"
}

variable "rds_secret_name" {
  type = string
}

variable "rds_endpoint" {
  type = string
}

variable "name_db_rds" {
  type = string
}