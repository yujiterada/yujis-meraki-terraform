variable "network_name" {
  description = "The name of the Meraki network"
  type        = string
}

variable "organization_id" {
  description = "The ID of the Meraki organization"
  type        = string
}

variable "network_timezone" {
  description = "The timezone for the Meraki network"
  type        = string
  default     = "Australia/Sydney"
}

variable "product_types" {
  description = "List of product types to include in the network"
  type        = list(string)
  default     = ["appliance", "camera", "cellularGateway", "sensor", "switch", "systemsManager", "wireless"]
}

variable "tags" {
  description = "List of tags to apply to the network"
  type        = list(string)
  default     = ["terraform"]
}

variable "notes" {
  description = "Notes for the network"
  type        = string
  default     = ""
}
