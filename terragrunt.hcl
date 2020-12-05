locals {
  module       = basename(get_terragrunt_dir())
  product_vars = yamldecode(file(find_in_parent_folders("product.yaml")))
  env          = get_env("ENV")
  product_name = local.product_vars.product_name
}

terraform {
  source = "../../modules/${local.module}"
}

inputs = {
  product_name = local.product_name
  environment  = local.state_key
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

