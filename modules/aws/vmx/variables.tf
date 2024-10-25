variable "ec2_instance_name" {
  description = "EC2 instance name of VMX instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type of VMX instance"
  type        = string
}

variable "has_public_ip" {
  description = "The VMX has a public IP associated"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "sg_name" {
  description = "Security group name of sg attached to VMX instance"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "vmx_token" {
  description = "The VMX token for user data"
  type        = string
}
