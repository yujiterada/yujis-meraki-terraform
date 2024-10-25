variable "network_id" {
  description = "The ID of the Meraki network"
  type        = string
}

variable "appliance_ip" {
  description = "The IP address of the appliance"
  type        = string
}

variable "subnet" {
  description = "The subnet for the single LAN"
  type        = string
}
