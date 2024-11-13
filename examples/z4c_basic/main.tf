module "network" {
  source                   = "../../modules/meraki/network/base"
  network_name             = var.network_name
  organization_id          = var.organization_id
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
