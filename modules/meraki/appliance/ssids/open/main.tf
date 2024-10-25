resource "meraki_networks_appliance_ssids" "ssid_open" {
  auth_mode       = "open"
  default_vlan_id = var.default_vlan_id
  enabled         = true
  name            = var.ssid_name
  network_id      = var.network_id
  number          = var.ssid_number
  visible         = true
}
