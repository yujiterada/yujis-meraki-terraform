resource "meraki_networks_appliance_traffic_shaping_rules" "base" {
  default_rules_enabled = true
  network_id            = var.network_id
  rules = [
    {
      definitions = [
        {
          type = "application"
          value_obj = {
            id   = "meraki:layer7/application/2214"
            name = "MS Teams Audio"
          }
        },

        {
          type = "application"
          value_obj = {
            id   = "meraki:layer7/application/2251"
            name = "Webex Audio"
          }
        },
        {
          type = "application"
          value_obj = {
            id   = "meraki:layer7/application/186"
            name = "Line"
          }
        },
        {
          type = "application"
          value_obj = {
            id   = "meraki:layer7/application/2469"
            name = "Facetime"
          }
        }
      ]
      dscp_tag_value = 34
      per_client_bandwidth_limits = {
        settings = "ignore"
      }
      priority = "high"
    },
    {
      definitions = [
        {
          type = "application"
          value_obj = {
            id   = "meraki:layer7/application/2130"
            name = "Zoom Meetings"
          }
        },

        {
          type = "application"
          value_obj = {
            id   = "meraki:layer7/application/2250"
            name = "Webex Video"
          }
        },
        {
          type = "application"
          value_obj = {
            id   = "meraki:layer7/application/2209"
            name = "MS Teams Video"
          }
        }
      ]
      dscp_tag_value = 36
      per_client_bandwidth_limits = {
        settings = "ignore"
      }
      priority = "high"
    }
  ]
}
