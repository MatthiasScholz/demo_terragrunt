resource "aws_vpc" "this" {
  tags       = {
    Name:var.product_name,
    Env: var.environment
  }
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "this" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.this.id
}


