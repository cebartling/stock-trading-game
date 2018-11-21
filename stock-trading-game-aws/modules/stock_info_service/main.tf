######################################################################################################################
#### AWS Lambda configuration
######################################################################################################################
data "aws_iam_policy_document" "stock_info_service_execution_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:*",

      //      "sqs:SendMessage",
      //      "ecs:RunTask",
      "iam:GetRole",

      "iam:PassRole",
    ]

    resources = [
      "arn:aws:logs:*:*:*",

      //      "arn:aws:sqs:*:*:*",
      //      "arn:aws:ecs:*:*:*",
      "arn:aws:iam::*:*",
    ]
  }
}

resource "aws_iam_policy" "stock_info_service_execution_policy" {
  policy = "${data.aws_iam_policy_document.stock_info_service_execution_role_policy.json}"
}

data "aws_iam_policy_document" "stock_info_service_execution_role_trust_policy" {
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

resource "aws_iam_role" "stock_info_service_iam_role" {
  name               = "stock_info_service_iam_role"
  assume_role_policy = "${data.aws_iam_policy_document.stock_info_service_execution_role_trust_policy.json}"
}

resource "aws_iam_role_policy_attachment" "iam_policy_basic_execution_for_workflow_lambda" {
  role       = "${aws_iam_role.stock_info_service_iam_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "iam_policy_stock_info_service_execution" {
  role       = "${aws_iam_role.stock_info_service_iam_role.id}"
  policy_arn = "${aws_iam_policy.stock_info_service_execution_policy.arn}"
}

resource "aws_lambda_function" "stock_info_service_function" {
  filename         = "worker-kickstart/deployment.zip"
  source_code_hash = "${base64sha256(file("worker-kickstart/deployment.zip"))}"
  function_name    = "stock-info-service"
  role             = "${aws_iam_role.stock_info_service_iam_role.arn}"
  handler          = "graphql.handler"
  runtime          = "nodejs8.10"
  publish          = true
  description      = "Stock information GraphQL API"
}
