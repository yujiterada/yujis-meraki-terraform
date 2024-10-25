module "traffic_shaping_rules" {
  source = "../../modules/meraki/appliance/traffic_shaping_rules/base"
  network_id = var.network_id
}

module "l3_firewall_rules" {
  source = "../../modules/meraki/appliance/firewall/l3_firewall_rules/base"
  network_id = var.network_id
}
