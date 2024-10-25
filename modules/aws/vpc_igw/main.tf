# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}
