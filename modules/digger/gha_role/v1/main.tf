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
  # https://docs.github.com/ja/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = anytrue([for sub in var.subjects : strcontains(sub, "*")]) ? "StringLike" : "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.subjects
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    resources = var.roles_to_assume
  }

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${var.tfplan_bucket_name}/*",
    ]
  }
}
