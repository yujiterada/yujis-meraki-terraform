locals {
  rules_file = jsondecode(file("./../../modules/data/meraki/shared/traffic_shaping_rules/base.json"))
  rules      = local.rules_file.rules
}

module "traffic_shaping_rules" {
  source     = "../../modules/meraki/appliance/traffic_shaping_rules/base"
  network_id = var.network_id
  rules      = local.rules
}

module "l3_firewall_rules" {
  source = "../../modules/meraki/appliance/firewall/l3_firewall_rules/base"
  network_id = var.network_id
}
