resource "meraki_networks_appliance_vlans_settings" "single_vlan" {
  network_id    = var.network_id
  vlans_enabled = false
}

output "meraki_networks_appliance_vlans_settings_single_vlan" {
  value = meraki_networks_appliance_vlans_settings.single_vlan
}

resource "meraki_networks_appliance_single_lan" "example" {
  appliance_ip = var.appliance_ip
  ipv6 = {
    enabled = false
  }
  mandatory_dhcp = {
    enabled = false
  }
  network_id = var.network_id
  subnet     = var.subnet
}

output "meraki_networks_appliance_single_lan_example" {
  value = meraki_networks_appliance_single_lan.example
}