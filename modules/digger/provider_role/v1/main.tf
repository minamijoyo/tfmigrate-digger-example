resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_policy" "this" {
  name   = aws_iam_role.this.name
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:sts::${var.digger_account_id}:assumed-role/${var.digger_gha_role}/GitHubActions"]
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    sid       = "AllowAllByDefault"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }

  statement {
    sid    = "DenyAssumeRole"
    effect = "Deny"

    actions   = ["sts:Assume*"]
    resources = ["*"]
  }

  statement {
    sid       = "DenyAllExceptAllowedRegions"
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"
      values   = var.allowed_regions
    }
  }

  override_policy_documents = var.override_policy_documents
}
