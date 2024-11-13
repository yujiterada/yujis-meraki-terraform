resource "meraki_networks_appliance_traffic_shaping_rules" "base" {
  default_rules_enabled = true
  network_id            = var.network_id
  rules                 = var.rules
}
