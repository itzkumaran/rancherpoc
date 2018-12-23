provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "~/.aws/config"
  profile                 = "default"
}

module "rancher" {
  source                 = "../modules/rancher"
  instance_count         = "1"
  availability_zones     = ["us-east-1a","us-east-1b","us-east-1c"]
  vpc_id                 = "vpc-505b032b"
}
