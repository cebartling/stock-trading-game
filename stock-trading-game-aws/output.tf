output "worker_lambda_new_version" {
  value = "${module.worker_lambda.workflow_lambda_function_version}"
}

output "workflow_s3_bucket" {
  value = "${module.s3.workflow_bucket}"
}

output "workflow_s3_bucket_arn" {
  value = "${module.s3.workflow_bucket_arn}"
}

output "base_url" {
  value = "${module.api_gateway.worker_api_gw_test_deployment_invoke_url}"
}

output "workflow_queue_url" {
  value = "${module.workflow_queue.workflow_queue_url}"
}

output "worker_task_definition_arn" {
  value = "${module.ecs.worker_task_definition_arn}"
}
