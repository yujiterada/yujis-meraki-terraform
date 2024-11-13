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
