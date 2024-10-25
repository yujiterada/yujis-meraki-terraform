variable "meraki_dashboard_api_key" {
  description = "Meraki Dashboard API key"
  type        = string
  sensitive   = true
}

variable "network_name" {
  description = "Name of the Meraki network"
  type        = string
}

variable "organization_id" {
  description = "Meraki organization ID"
  type        = string
}

variable "serials" {
  description = "List of device serials to claim"
  type        = list(string)
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

variable "ssid_psk_name" {
  description = "Name of the PSK SSID"
  type        = string
}

variable "ssid_psk_number" {
  description = "Number of the PSK SSID"
  type        = number
}

variable "ssid_open_name" {
  description = "Name of the Open SSID"
  type        = string
}

variable "ssid_open_number" {
  description = "Number of the Open SSID"
  type        = number
}

variable "psk" {
  description = "Pre-shared key for the PSK SSID"
  type        = string
  sensitive   = true
}
