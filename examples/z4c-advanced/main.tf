module "network" {
  source          = "../../modules/meraki/network/base"
  network_name    = var.network_name
  organization_id = var.organization_id
}

locals {
  network_id = module.network.id
}

# Claim devices to the network
resource "meraki_networks_devices_claim" "claimed_devices" {
  network_id = local.network_id
  parameters = {
    serials = var.serials
  }
}

module "appliance_vlans_multi_ipv4_only" {
  source     = "../../modules/meraki/appliance/vlans/multi_ipv4_only"
  network_id = local.network_id
  vlan_list  = var.vlan_list
}

resource "meraki_networks_appliance_ports" "corp_port" {
  access_policy         = "open"
  enabled               = true
  network_id            = local.network_id
  port_id               = 2
  type                  = "access"
  vlan                  = var.vlan_list[0].vlan_id
  depends_on            = [module.appliance_vlans_multi_ipv4_only]
}

resource "meraki_networks_appliance_ports" "guest_port" {
  access_policy         = "open"
  enabled               = true
  network_id            = local.network_id
  port_id               = 3
  type                  = "access"
  vlan                  = var.vlan_list[1].vlan_id
  depends_on            = [meraki_networks_appliance_ports.corp_port]
}

# Call the PSK SSID module
module "psk_ssid" {
  source = "../../modules/meraki/appliance/ssids/psk"

  default_vlan_id = var.vlan_list[0].vlan_id
  ssid_name       = var.ssid_psk_name
  network_id      = local.network_id
  ssid_number     = var.ssid_psk_number
  psk             = var.psk
  depends_on      = [module.appliance_vlans_multi_ipv4_only]
}

# Call the PSK SSID module
module "open_ssid" {
  source = "../../modules/meraki/appliance/ssids/open"

  default_vlan_id = var.vlan_list[1].vlan_id
  ssid_name       = var.ssid_open_name
  network_id      = local.network_id
  ssid_number     = var.ssid_open_number
  depends_on      = [module.appliance_vlans_multi_ipv4_only]
}

module "traffic_shaping_rules" {
  source = "../../modules/meraki/appliance/traffic_shaping_rules/base"
  network_id = local.network_id
}
