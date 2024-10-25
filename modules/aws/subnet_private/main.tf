# Create a private subnet
resource "aws_subnet" "subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block
}

# Create a route table for the private subnet
resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.natgw_id
  }
}

# Associate the private route table with the private subnet
resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.private_rt.id
}