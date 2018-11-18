output "workflow_queue_url" {
  value = "${aws_sqs_queue.workflow_queue.id}"
}
