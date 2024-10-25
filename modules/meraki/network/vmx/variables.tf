variable "meraki_dashboard_api_key" {
  description = "Meraki Dashboard API Key for authentication"
  type        = string
  sensitive   = true
}

variable "network_name" {
  description = "Meraki Network name"
  type        = string
}

variable "organization_id" {
  description = "Meraki Organization ID"
  type        = string
}

variable "vmx_license_size" {
  description = "Meraki license size for vMX"
  type        = string
}
