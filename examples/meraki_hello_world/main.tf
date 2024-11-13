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
  meraki_dashboard_api_key = "12345"
}

resource "meraki_networks" "test_network" {
  name            = "Test network"
  # Change the below to your Meraki organization ID. This can be found at the bottom of Meraki dashboard.
  organization_id = "12345"
  product_types   = ["appliance", "switch", "wireless"]
}
