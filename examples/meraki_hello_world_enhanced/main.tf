resource "meraki_networks" "test_network" {
  # Change the below to your Meraki organization ID. This can be found at the bottom of Meraki dashboard.
  organization_id = var.organization_id
  name            = var.network_name
  product_types   = ["appliance", "switch", "wireless"]
}
