variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  sensitive   = true
}

variable "meraki_dashboard_api_key" {
  description = "Meraki Dashboard API Key for authentication"
  type        = string
  sensitive   = true
}

variable "meraki_network_name" {
  description = "Meraki Network name"
  type        = string
}

variable "meraki_organization_id" {
  description = "Meraki Organization ID"
  type        = string
}

variable "security_group_name" {
  description = "Security group name of sg attached to VMX instance"
  type        = string
}

variable "subnet_public_cidr_block" {
  description = "CIDR block for the public subnet within the VPC"
  type        = string
}

variable "subnet_private_cidr_block" {
  description = "CIDR block for the private subnet within the VPC"
  type        = string
}

variable "vmx_has_public_ip" {
  description = "Boolean to determine if the vMX instance should have a public IP"
  type        = bool
}

variable "vmx_instance_name" {
  description = "EC2 instance name for vMX. Options are c5.large, m4.large, and c5.xlarge."
  type        = string
}

variable "vmx_instance_type" {
  description = "EC2 instance type for vMX. Options are c5.large, m4.large, and c5.xlarge."
  type        = string
}

variable "vmx_license_size" {
  description = "Meraki license size for vMX"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}
