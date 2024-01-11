locals {
  module       = basename(get_terragrunt_dir())
  product_vars = yamldecode(file(find_in_parent_folders("product.yaml")))
  env          = get_env("ENV")
  product_name = local.product_vars.product_name
  state_key="${local.product_name}/${local.env}/${local.module}"
}

terraform {
  source = "../../modules/${local.module}"
}

inputs = {
  product_name = local.product_name
  environment  = local.env
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region="eu-central-1"
}
EOF
}

remote_state {
  backend  = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config   = {
    bucket  = "tw-infra-test-bucket"
    key     = "${local.state_key}/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}

