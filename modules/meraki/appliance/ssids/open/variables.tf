variable "default_vlan_id" {
  description = "Default VLAN ID for the SSID"
  type        = number
}

variable "ssid_name" {
  description = "Name of the SSID"
  type        = string
}

variable "network_id" {
  description = "ID of the Meraki network"
  type        = string
}

variable "ssid_number" {
  description = "Number of the SSID"
  type        = number
}
