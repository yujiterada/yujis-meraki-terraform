output "network_id" {
  value = meraki_networks.vmx_network.id
}

output "vmx_token" {
  value = meraki_devices_appliance_vmx_authentication_token.vmx_token.item.token
}
