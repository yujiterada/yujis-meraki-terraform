resource "meraki_networks_appliance_firewall_l3_firewall_rules" "base" {
  network_id = var.network_id
  rules = [{
    comment        = "Deny traffic to Cloudflare"
    dest_cidr      = "1.1.1.1/32"
    dest_port      = "any"
    policy         = "deny"
    protocol       = "any"
    src_cidr       = "any"
    src_port       = "any"
    syslog_enabled = false
  }]
}
