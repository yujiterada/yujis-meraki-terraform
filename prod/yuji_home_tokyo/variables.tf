variable "meraki_dashboard_api_key" {
  description = "Meraki Dashboard API key"
  type        = string
  sensitive   = true
}

variable "network_id" {
  description = "Meraki network ID"
  type        = string
}