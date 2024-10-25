# Create a subnet
resource "aws_subnet" "subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block

  availability_zone = "us-west-2a"
}

# Create a route table for the public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

# Associate the public route table with the public subnet
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.public_rt.id
}
