variable "tags" {
  type        = map(any)
  description = "Tags a serem adicionadas aos recursos da AWS"
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
}


variable "private_subnet_1a" {
  type        = string
  description = "ID subnet privada AZ 1a"
}

variable "private_subnet_1b" {
  type        = string
  description = "ID subnet privada AZ 1b"
}