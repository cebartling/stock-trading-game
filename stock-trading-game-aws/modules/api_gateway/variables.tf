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

variable "stock_info_service_lambda_function_invoke_arn" {
  description = "The invoke ARN for the Stock Info Service Lambda function that will be tied to API Gateway"
}

variable "stock_info_service_lambda_function_arn" {
  description = "The ARN for the Stock Info Service Lambda function that will be tied to API Gateway"
}
