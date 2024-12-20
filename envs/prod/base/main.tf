data "aws_caller_identity" "current" {}

module "digger_provider_role_aws" {
  source = "../../../modules/digger/provider_role/v1"

  name              = "digger-provider-aws-prod"
  digger_account_id = data.aws_caller_identity.current.account_id
  digger_gha_role   = "digger-gha-aws"
  allowed_regions   = ["us-east-1", "ap-northeast-1"]
}
