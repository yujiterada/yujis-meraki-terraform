variable "meraki_dashboard_api_key" {
  description = "Meraki Dashboard API Key for authentication"
  type        = string
  sensitive   = true
}

variable "network_id" {
  description = "Meraki Network ID"
  type        = string
}