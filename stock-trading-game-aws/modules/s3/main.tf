######################################################################################################################
#### S3 configuration
######################################################################################################################
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "workflow_bucket" {
  bucket = "${var.aws_bucket}${data.aws_caller_identity.current.account_id}"

  tags {
    Environment = "${var.environment}"
  }
}

data "aws_iam_policy_document" "aws_s3_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]

    principals {
      type = "*"

      identifiers = [
        "*",
      ]
    }
  }
}

data "aws_iam_policy_document" "aws_s3_workflow_bucket_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      "${aws_s3_bucket.workflow_bucket.arn}",
    ]

    principals {
      type = "*"

      identifiers = [
        "*",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.workflow_bucket.arn}/*",
    ]

    principals {
      type = "*"

      identifiers = [
        "*",
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "workflow_bucket" {
  bucket = "${aws_s3_bucket.workflow_bucket.id}"
  policy = "${data.aws_iam_policy_document.aws_s3_workflow_bucket_policy_document.json}"
}
