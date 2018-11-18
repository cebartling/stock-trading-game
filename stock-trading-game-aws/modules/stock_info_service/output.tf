output "workflow_lambda_function_invoke_arn" {
  value = "${aws_lambda_function.workflow_lambda_function.invoke_arn}"
}

output "workflow_lambda_function_arn" {
  value = "${aws_lambda_function.workflow_lambda_function.arn}"
}

output "workflow_lambda_function_version" {
  value = "${aws_lambda_function.workflow_lambda_function.version}"
}
