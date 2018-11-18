variable "vpc_cidr" {
  description = "The CIDR block of the virtual private cloud."
}

variable "public_subnets_cidr" {
  type        = "list"
  description = "The CIDR block for the public subnet."
}

variable "private_subnets_cidr" {
  type        = "list"
  description = "The CIDR block for the private subnet."
}

variable "environment" {
  description = "The environment."
}

variable "region" {
  description = "The region to launch the bastion host."
}

variable "availability_zones" {
  type        = "list"
  description = "The availability zones that will be used to launch the resources."
}

variable "key_name" {
  description = "The public key for the bastion host."
}
