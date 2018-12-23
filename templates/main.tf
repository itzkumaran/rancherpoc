provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "~/.aws/config"
  profile                 = "default"
}

module "rancher" {
  source                 = "../modules/rancher"
  instance_count         = "1"
}
