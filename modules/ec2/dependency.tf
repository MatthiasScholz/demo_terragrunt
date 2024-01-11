data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "tw-infra-test-bucket"
    key            = "the-cool-product/test/application-base/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}
