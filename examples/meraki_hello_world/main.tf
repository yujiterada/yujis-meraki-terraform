terraform {
  required_providers {
    meraki = {
      source  = "cisco-open/meraki"
      version = "0.2.12-alpha"
    }
  }
}

provider "meraki" {
  # Change the below to your Meraki API key.
  meraki_dashboard_api_key = "a769b73ffc7df5ed9eb6f0a688b824cc30032427"
}

resource "meraki_networks" "test_network" {
  # Change the below to the name of the network you want to create.
  name            = "Test network"
  # Change the below to your Meraki organization ID. This can be found at the bottom of Meraki dashboard.
  organization_id = "892608"
  product_types   = ["appliance", "switch", "wireless"]
}
