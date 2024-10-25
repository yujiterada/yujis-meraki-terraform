# output "organizations" {
#   value = data.meraki_organizations.organizations
# }

# output "networks" {
#   value = data.meraki_networks.networks
# }

output "vmx_token" {
  value = module.meraki_network_vmx.vmx_token
}

# If you want to use the outputs from the module
output "vmx_instance_id" {
  value = module.aws_vmx.instance_id
}

output "vmx_instance_public_ip" {
  value = module.aws_vmx.public_ip
}

output "ubuntu_instance_id" {
  value = module.aws_ubuntu.instance_id
}

output "ubuntu_private_ip" {
  value = module.aws_ubuntu.private_ip
}

# # Output the AMI ID
# output "ami_id" {
#   description = "The ID of the Marketplace AMI"
#   value       = data.aws_ami.marketplace_vmx.id
# }

# # Output the AMI name
# output "ami_name" {
#   description = "The name of the Marketplace AMI"
#   value       = data.aws_ami.marketplace_vmx.name
# }

# # Output the AMI description
# output "ami_description" {
#   description = "The description of the Marketplace AMI"
#   value       = data.aws_ami.marketplace_vmx.description
# }
