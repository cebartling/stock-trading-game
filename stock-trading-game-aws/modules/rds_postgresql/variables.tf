//variable "rds_vpc_id" {
//  default = "vpc-XXXXXXXX"
//  description = "Our default RDS virtual private cloud (rds_vpc)."
//}
//
//variable "rds_public_subnets" {
//  default = "subnet-YYYYYYYY,subnet-YYYYYYYY,subnet-YYYYYYYY,subnet-YYYYYYYY"
//  description = "The public subnets of our RDS VPC rds-vpc."
//}
//
//variable "rds_public_subnet_group" {
//  default = "default-vpc-XXXXXXXX"
//  description = "Apparently the group name, according to the RDS launch wizard."
//}

variable "environment" {
  description = "Identifies the environment tag used for all resources in this solution."
}

variable "application" {
  description = "Identifies the application tag used for all resources in this solution."
}

variable "provisioner" {
  description = "Identifies the provisioner tag useed for all resources in this solution."
}

variable "aws_region" {
  description = "The AWS Region to use for provisioning all resources in this solution."
}
