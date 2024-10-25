variable "network_id" {
  description = "The ID of the Meraki network"
  type        = string
}

variable "vlan_list" {
  description = "List of VLAN configurations"
  type = list(object({
    appliance_ip = string
    vlan_id      = string
    name         = string
    subnet       = string
  }))
}
