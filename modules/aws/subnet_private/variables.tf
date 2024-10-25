variable "vpc_id" {
  description = "The ID of the VPC where the subnet will be created"
  type        = string
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "natgw_id" {
  description = "The ID of the NAT Gateway to use for outbound internet access"
  type        = string
}
