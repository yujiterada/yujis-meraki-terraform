resource "meraki_networks_appliance_ssids" "ssid_psk" {
  auth_mode       = "psk"
  default_vlan_id = var.default_vlan_id
  dot11w = {
    enabled  = true
    required = true
  }
  enabled             = true
  encryption_mode     = "wpa"
  name                = var.ssid_name
  network_id          = var.network_id
  number              = var.ssid_number
  psk                 = var.psk
  visible             = true
  wpa_encryption_mode = "WPA2 only"
}
