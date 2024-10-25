resource "meraki_networks" "vmx_network" {
  name                = var.network_name
  organization_id     = var.organization_id
  product_types       = ["appliance"]
}

resource "meraki_networks_devices_claim_vmx" "vmx" {
  network_id = meraki_networks.vmx_network.id
  parameters = {
    size = var.vmx_license_size
  }
}

resource "meraki_devices_appliance_vmx_authentication_token" "vmx_token" {
  serial = meraki_networks_devices_claim_vmx.vmx.item.serial
}
