module "aws_vpc_igw" {
  source = "../../modules/aws/vpc_igw"
  vpc_cidr_block = var.vpc_cidr_block
}

module "aws_subnet_public" {
  source            = "../../modules/aws/subnet_public"
  vpc_id            = module.aws_vpc_igw.vpc_id
  igw_id            = module.aws_vpc_igw.igw_id
  subnet_cidr_block = var.subnet_cidr_block
}

module "aws_vmx" {
  source            = "../../modules/aws/vmx"
  ec2_instance_name = var.vmx_instance_name
  ec2_instance_type = var.vmx_instance_type
  vpc_id            = module.aws_vpc_igw.vpc_id
  sg_name           = var.security_group_name
  subnet_id         = module.aws_subnet_public.id
  vmx_token         = module.meraki_network_vmx.vmx_token
  has_public_ip     = var.vmx_has_public_ip
}

module "meraki_network_vmx" {
  source                   = "../../modules/meraki/network/vmx"
  meraki_dashboard_api_key = var.meraki_dashboard_api_key
  network_name             = var.meraki_network_name 
  organization_id          = var.meraki_organization_id
  vmx_license_size         = var.vmx_license_size
}

module "meraki_passthrough_hub" {
  source                   = "../../modules/meraki/vmx/passthrough_hub"
  meraki_dashboard_api_key = var.meraki_dashboard_api_key
  network_id               = module.meraki_network_vmx.network_id
}

module "aws_ubuntu" {
  source           = "../../modules/aws/ubuntu"
  subnet_id        = module.aws_subnet_public.id
  vpc_id           = module.aws_vpc_igw.vpc_id
}
