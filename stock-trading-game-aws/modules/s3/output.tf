output "workflow_bucket_arn" {
  value = "${aws_s3_bucket.workflow_bucket.arn}"
}

output "workflow_bucket" {
  value = "${aws_s3_bucket.workflow_bucket.bucket}"
}
