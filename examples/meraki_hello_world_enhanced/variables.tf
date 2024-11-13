variable "meraki_dashboard_api_key" {
  description = "Meraki Dashboard API key"
  type        = string
  sensitive   = true
}

variable "network_name" {
  description = "Name of the Meraki network to create"
  type        = string
}

variable "organization_id" {
  description = "Meraki organization ID. This can be found at the bottom of Meraki dashboard."
  type        = string
}