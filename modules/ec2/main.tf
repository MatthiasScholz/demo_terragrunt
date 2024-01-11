resource "aws_instance" "this" {
  ami           = data.aws_ami.lovely_ami.id
  instance_type = "t2.micro"
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
  tags = {
    a="${var.product_name}/${var.environment}/application-base/terraform.tfstate"
  }
}

//module "asd" {
//  source = "git://sh tag=v2.5"
//}

# Get AMI
data aws_ami lovely_ami {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}
