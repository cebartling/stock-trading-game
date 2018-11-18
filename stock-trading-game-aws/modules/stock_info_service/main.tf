######################################################################################################################
#### AWS Lambda configuration
######################################################################################################################
data "aws_iam_policy_document" "aws_lambda_execution_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:*",
      "sqs:SendMessage",
      "ecs:RunTask",
      "iam:GetRole",
      "iam:PassRole",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
      "arn:aws:sqs:*:*:*",
      "arn:aws:ecs:*:*:*",
      "arn:aws:iam::*:*",
    ]
  }
}

resource "aws_iam_policy" "workflow_lambda_execution_policy" {
  policy = "${data.aws_iam_policy_document.aws_lambda_execution_role_policy.json}"
}

data "aws_iam_policy_document" "aws_lambda_execution_role_trust_policy" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      identifiers = [
        "lambda.amazonaws.com",
      ]

      type = "Service"
    }
  }
}

resource "aws_iam_role" "iam_for_workflow_lambda" {
  name               = "workflow_lambda_iam_role"
  assume_role_policy = "${data.aws_iam_policy_document.aws_lambda_execution_role_trust_policy.json}"
}

resource "aws_iam_role_policy_attachment" "iam_policy_basic_execution_for_workflow_lambda" {
  role       = "${aws_iam_role.iam_for_workflow_lambda.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "iam_policy_workflow_lambda_execution" {
  role       = "${aws_iam_role.iam_for_workflow_lambda.id}"
  policy_arn = "${aws_iam_policy.workflow_lambda_execution_policy.arn}"
}

resource "aws_lambda_function" "workflow_lambda_function" {
  filename         = "worker-kickstart/deployment.zip"
  source_code_hash = "${base64sha256(file("worker-kickstart/deployment.zip"))}"
  function_name    = "worker_lambda"
  role             = "${aws_iam_role.iam_for_workflow_lambda.arn}"
  handler          = "handler.handler"
  runtime          = "nodejs6.10"
  publish          = true
  description      = "Glue code for enqueuing a message and starting the Docker container in ECS."
}

data "template_file" "workflow_lambda_function_config_json" {
  template = <<EOF
{
    "queue": "$${queue}",
    "task": "$${task}",
    "s3_key_suffix_whitelist": [".zip"],
    "ecs_cluster_name": "$${ecs_cluster_name}",
    "ecs_subnet_ids": $${ecs_subnet_ids},
    "workflow_bucket_arn": "$${workflow_bucket_arn}"
}
EOF

  vars {
    queue               = "${var.workflow_queue_url}"
    task                = "${var.worker_task_definition_arn}"
    ecs_cluster_name    = "${var.aws_ecs_cluster_name}"
    ecs_subnet_ids      = "${jsonencode(var.private_subnets_id)}"
    workflow_bucket_arn = "${var.workflow_bucket_arn}"
  }
}

resource "local_file" "workflow_lambda_function_config_local_file" {
  filename = "${var.filename}"
  content  = "${data.template_file.workflow_lambda_function_config_json.rendered}"
}
