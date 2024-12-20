tfmigrate {
  migration_dir = "./tfmigrate"

  history {
    storage "s3" {
      region  = "ap-northeast-1"
      bucket  = "minamijoyo-digger-tfstate-aws"
      key     = "tfmigrate/history.json"
      profile = "minamijoyo-tfstate"
    }
  }
}
