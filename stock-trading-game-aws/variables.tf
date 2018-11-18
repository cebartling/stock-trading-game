variable "environment" {
  default     = "dev"
  description = "Identifies the environment tag used for all resources in this solution."
}

variable "application" {
  default     = "stock-trading-game"
  description = "Identifies the application tag used for all resources in this solution."
}

variable "provisioner" {
  description = "Identifies the provisioner tag useed for all resources in this solution."
}

variable "aws_region" {
  description = "The AWS Region to use for provisioning all resources in this solution."
}

variable "app_name" {
  default = "ECSPOVRayWorker"
}

//variable "app_env" {
//    description = "Application execution environment"
//}

variable "aws_profile" {
  default = "default"
}

variable "aws_bucket" {
  default = "stock-trading-game-bucket-"
}

variable "sqs_queue_name" {
  default = "StockTradingGameWorkerQueue"
}

variable "lambda_function_name" {
  default = "ecs-worker-launcher"
}

variable "ecs_task_name" {
  default = "ECSPOVRayWorkerTask"
}

variable "bucket_permission_sid" {
  default = "ECSPOVRayWorkerPermission"
}

variable "wait_time" {
  default = 5
}

variable "retries" {
  default = 5
}

variable "lambda_execution_role_name" {
  default = "ECSPOVRayWorker-Lambda-Execution-Role"
}

variable "lambda_execution_role_policy_name" {
  default = "AWSLambdaExecutionPolicy"
}
