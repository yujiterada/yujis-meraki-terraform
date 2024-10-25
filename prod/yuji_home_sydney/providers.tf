terraform {
  required_providers {
    meraki = {
      source  = "cisco-open/meraki"
      version = "0.2.12-alpha"
    }
  }

  backend "s3" {
    bucket         = "s3-yujis-meraki-scripts"
    key            = "terraform/yuji_home_sydney/terraform.tfstate"
    encrypt        = true
    region         = "ap-southeast-2"
  }
}

provider "meraki" {
  meraki_dashboard_api_key = var.meraki_dashboard_api_key
  meraki_debug = true
}
