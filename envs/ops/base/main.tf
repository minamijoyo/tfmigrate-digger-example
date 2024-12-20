locals {
  account_id          = data.aws_caller_identity.current.account_id
  tfstate_bucket_name = "minamijoyo-digger-tfstate-aws"
  tflock_table_name   = "tflock"
  tfplan_bucket_name  = "minamijoyo-digger-tfplan-aws"
  oidc_subjects       = ["repo:minamijoyo/tfmigrate-digger-example:*"]
}

data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}

module "tfstate_aws" {
  source = "../../../modules/tfstate_backend_s3/v1"

  s3_bucket_name      = local.tfstate_bucket_name
  dynamodb_table_name = local.tflock_table_name
}

module "digger_tfplan_bucket_aws" {
  source = "../../../modules/digger/tfplan_bucket/v1"

  name            = local.tfplan_bucket_name
  expiration_days = 30
}

module "digger_gha_role_aws" {
  source = "../../../modules/digger/gha_role/v1"

  name       = "digger-gha-aws"
  account_id = local.account_id
  subjects   = local.oidc_subjects
  roles_to_assume = [
    "arn:aws:iam::${local.account_id}:role/digger-tfstate-aws",
    "arn:aws:iam::*:role/digger-provider-aws-*",
  ]
  tfplan_bucket_name = module.digger_tfplan_bucket_aws.name
}

module "digger_tfstate_role_aws" {
  source = "../../../modules/digger/tfstate_role/v1"

  name                = "digger-tfstate-aws"
  digger_account_id   = local.account_id
  digger_gha_role     = module.digger_gha_role_aws.name
  tfstate_bucket_name = local.tfstate_bucket_name
  tflock_table_name   = local.tflock_table_name
}

module "digger_provider_role_aws" {
  source = "../../../modules/digger/provider_role/v1"

  name              = "digger-provider-aws-ops"
  digger_account_id = local.account_id
  digger_gha_role   = module.digger_gha_role_aws.name
  allowed_regions   = ["us-east-1", "ap-northeast-1"]
}
