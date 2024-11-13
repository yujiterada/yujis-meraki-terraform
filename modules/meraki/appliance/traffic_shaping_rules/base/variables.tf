variable "network_id" {
  description = "ID of the Meraki network"
  type        = string
}

variable "rules" {
  description = "Rules to apply to the network"
  type        = list(any)
}
