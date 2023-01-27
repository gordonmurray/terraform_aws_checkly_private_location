terraform {

  required_version = "1.2.3"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "4.20.0"

    }

    checkly = {
      source  = "checkly/checkly"
      version = "1.6.3"
    }

  }

}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "gordonmurray"

  default_tags {
    tags = {
      App = "terraform_aws_checkly_private_location"
    }
  }

}

provider "checkly" {
  api_key    = var.checkly_api_key
  account_id = var.checkly_account_id
}