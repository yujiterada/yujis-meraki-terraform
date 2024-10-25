terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    meraki = {
      source = "cisco-open/meraki"
      version = "0.2.5-alpha"
    }
  }
}

provider "aws" {
  # AWS credentials will be automatically picked up from environment variables
  region = var.aws_region
}

provider "meraki" {
  meraki_dashboard_api_key = var.meraki_dashboard_api_key
}
