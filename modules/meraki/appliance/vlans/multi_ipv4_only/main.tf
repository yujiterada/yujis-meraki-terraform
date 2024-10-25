resource "meraki_networks_appliance_vlans_settings" "multi_vlan" {
  network_id    = var.network_id
  vlans_enabled = true
}

output "meraki_networks_appliance_vlans_settings_multi_vlan" {
  value = meraki_networks_appliance_vlans_settings.multi_vlan
}

resource "meraki_networks_appliance_vlans" "appliance_vlans" {
  for_each = {
    for vlan in var.vlan_list : vlan.vlan_id => vlan
  }
  appliance_ip = each.value.appliance_ip
  id           = each.value.vlan_id
  ipv6 = {
    enabled = false
  }
  mandatory_dhcp = {
    enabled = false
  }
  name       = each.value.name
  network_id = var.network_id
  subnet     = each.value.subnet
  depends_on = [meraki_networks_appliance_vlans_settings.multi_vlan]
}

resource "meraki_networks_appliance_firewall_l3_firewall_rules" "guest_firewall_rules" {
  network_id = var.network_id
  rules = [
    {
      comment        = "Allow subnet access for guests"
      dest_cidr      = var.vlan_list[1].appliance_ip
      dest_port      = "Any"
      policy         = "allow"
      protocol       = "any"
      src_cidr       = var.vlan_list[1].subnet
      src_port       = "Any"
      syslog_enabled = false
    },
    {
      comment        = "Allow subnet access for guests"
      dest_cidr      = "255.255.255.255/32"
      dest_port      = "Any"
      policy         = "allow"
      protocol       = "any"
      src_cidr       = var.vlan_list[1].subnet
      src_port       = "Any"
      syslog_enabled = false
    },
    {
      comment        = "Deny class A private networks for guests"
      dest_cidr      = "10.0.0.0/8"
      dest_port      = "Any"
      policy         = "deny"
      protocol       = "any"
      src_cidr       = var.vlan_list[1].subnet
      src_port       = "Any"
      syslog_enabled = false
    },
    {
      comment        = "Deny class B private networks for guests"
      dest_cidr      = "172.16.0.0/12"
      dest_port      = "Any"
      policy         = "deny"
      protocol       = "any"
      src_cidr       = var.vlan_list[1].subnet
      src_port       = "Any"
      syslog_enabled = false
    },
    {
      comment        = "Deny class C private networks for guests"
      dest_cidr      = "192.168.0.0/16"
      dest_port      = "Any"
      policy         = "deny"
      protocol       = "any"
      src_cidr       = var.vlan_list[1].subnet
      src_port       = "Any"
      syslog_enabled = false
    },
    {
      comment        = "Allow internet access for guests"
      dest_cidr      = "Any"
      dest_port      = "Any"
      policy         = "allow"
      protocol       = "any"
      src_cidr       = var.vlan_list[1].subnet
      src_port       = "Any"
      syslog_enabled = false
    }
  ]
  depends_on = [meraki_networks_appliance_vlans.appliance_vlans]
}
