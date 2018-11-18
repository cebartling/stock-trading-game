######################################################################################################################
#### SQS configuration
######################################################################################################################

resource "aws_sqs_queue" "workflow_queue_deadletter" {
  name                      = "workflow-spike-deadletter-queue"
  delay_seconds             = 0
  max_message_size          = 8192
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags {
    Environment = "${var.environment}"
  }
}

data "aws_iam_policy_document" "aws_sqs_workflow_queue_deadletter_policy_document" {
  statement {
    sid    = "First"
    effect = "Allow"

    actions = [
      "sqs:SendMessage",
    ]

    resources = [
      "${aws_sqs_queue.workflow_queue_deadletter.arn}",
    ]

    condition {
      test = "ArnEquals"

      values = [
        "${aws_sqs_queue.workflow_queue_deadletter.arn}",
      ]

      variable = "aws:SourceArn"
    }
  }
}

resource "aws_sqs_queue_policy" "workflow_queue_deadletter" {
  queue_url = "${aws_sqs_queue.workflow_queue_deadletter.id}"
  policy    = "${data.aws_iam_policy_document.aws_sqs_workflow_queue_deadletter_policy_document.json}"
}

resource "aws_sqs_queue" "workflow_queue" {
  name                      = "workflow-spike-queue"
  delay_seconds             = 0
  max_message_size          = 8192
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.workflow_queue_deadletter.arn}\",\"maxReceiveCount\":4}"

  tags {
    Environment = "${var.environment}"
  }
}

data "aws_iam_policy_document" "aws_sqs_workflow_queue_policy_document" {
  statement {
    sid    = "First"
    effect = "Allow"

    actions = [
      "sqs:SendMessage",
    ]

    resources = [
      "${aws_sqs_queue.workflow_queue.arn}",
    ]

    condition {
      test = "ArnEquals"

      values = [
        "${aws_sqs_queue.workflow_queue.arn}",
      ]

      variable = "aws:SourceArn"
    }
  }
}

resource "aws_sqs_queue_policy" "workflow_queue" {
  queue_url = "${aws_sqs_queue.workflow_queue.id}"
  policy    = "${data.aws_iam_policy_document.aws_sqs_workflow_queue_policy_document.json}"
}
