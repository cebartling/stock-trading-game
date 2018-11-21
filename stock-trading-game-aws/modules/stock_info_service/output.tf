output "stock_info_service_function_invoke_arn" {
  value = "${aws_lambda_function.stock_info_service_function.invoke_arn}"
}

output "stock_info_service_function_arn" {
  value = "${aws_lambda_function.stock_info_service_function.arn}"
}

output "stock_info_service_function_version" {
  value = "${aws_lambda_function.stock_info_service_function.version}"
}
