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

variable "workflow_queue_url" {
  description = "The SQS workflow queue URL (which is its id)."
}

variable "worker_task_definition_arn" {
  description = "ARN for the ECS worker task definition."
}

variable "aws_ecs_cluster_name" {
  description = "The name of the ECS cluster."
}

variable "private_subnets_id" {
  type        = "list"
  description = "Array of private subnet identifiers."
}

variable "filename" {
  description = "The local filename of the workflow Lambda configuration JSON file."
  default     = "./worker-kickstart/config.json"
}

variable "workflow_bucket_arn" {
  description = "The ARN for the workflow S3 bucket."
}
