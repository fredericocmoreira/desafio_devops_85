variable "tags" {
  type        = map(any)
  description = "Tags a serem adicionadas aos recursos da AWS"
}

variable "vpc_ec2_devops" {
  type        = string
  description = "VPC Ec2"
}

variable "subnet_ec2_devops" {
  type        = string
  description = "VPC Ec2"
}
