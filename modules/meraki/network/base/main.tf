# Create a combined network
resource "meraki_networks" "network" {
  name            = var.network_name
  organization_id = var.organization_id
  notes           = var.notes
  product_types   = var.product_types
  tags            = var.tags
  time_zone       = var.network_timezone
}

resource "meraki_networks_traffic_analysis" "traffic_analysis" {
  mode       = "detailed"
  network_id = meraki_networks.network.id
}
