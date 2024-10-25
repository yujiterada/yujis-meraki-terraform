resource "meraki_networks_appliance_settings" "passthrough" {
  client_tracking_method = "MAC address"
  deployment_mode        = "passthrough"
  network_id = var.network_id
}

resource "meraki_networks_appliance_vpn_site_to_site_vpn" "hub" {
  mode       = "hub"
  network_id = var.network_id
}
