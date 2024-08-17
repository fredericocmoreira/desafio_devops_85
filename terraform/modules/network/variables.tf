variable "bloco_cidr" {
  type        = string
  description = "Bloco CIDR de rede a ser usado para o VPC"
}

variable "tags" {
  type        = map(any)
  description = "Tags a serem adicionadas aos recursos da AWS"
}