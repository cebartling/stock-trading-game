variable "environment" {
  description = "Identifies the environment tag used for all resources in this solution."
}

variable "application" {
  description = "Identifies the application tag used for all resources in this solution."
}

variable "provisioner" {
  description = "Identifies the provisioner tag used for all resources in this solution."
}

variable "aws_region" {
  description = "The AWS Region to use for provisioning all resources in this solution."
}

variable "deployment_zip_file" {
  description = "Path name for the stock info service deployment ZIP file."
}
