To be fixed

# terraform-vmx-basic
Terraform script to spin up a hub concentrator vMX in AWS with a public IP on the instance. Running the script only takes about 30 seconds and the vMX instsance will be up in about 5 minutes. Moreover, it takes about 5 minutes to destroy the environment.

## Installation

Use a package management system such as [Chocolatey](https://chocolatey.org/) or [Homebrew](https://brew.sh/) and isntall Terraform.

On Windows, run:
```
choco install terraform
```

On macOS, run:
```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## Setup
### 1. Download the folder _terraform-vmx-basic_
### 2. Generate an AWS access key
Navigate to _Identity Access and Management (IAM)_ on the AWS console and click on _User groups_ located in the left pane.

Create a user group, and attach the following permision policies.

- AmazonEC2FullAccess
- AmazonVPCFullAccess
- AWSMarketplaceFullAccess

Next, create a user by clicking on _User_ in the left pane and add the user to the created group. There is no need to tick _Provide user access to the AWS Management Console_.

Finally, navigate to the created user, click on _Security credentials_ tab, and generate access key.

### 3. Generate a Meraki API key

Open Meraki Dashboard, and navigate to _Organization > API and webhooks > API keys and access_. Click on _Generate API Key_.

### 4. Add 1 and 2 as an environmental variable
```
yujiterada@mac terraform-vmx-basic % env
MERAKI_DASHBOARD_API_KEY=XXX
AWS_ACCESS_KEY_ID=AAA
AWS_SECRET_ACCESS_KEY=BBB
```
### 5. Edit ./terraform-vmx-basic/terraform.tfvars

Edit to your preference. View _./terraform-vmx-basic/variables.tf_ for definition of the variables. The Meraki organization ID can be found in the footer of Meraki Dashboard.

i.e. _Data for Yuji Terada Personal (organization ID: 734417) is hosted in Asia-Pacific_

```
aws_region = "us-west-2"
meraki_network_name = "AWS"
meraki_organization_id = "734417"
security_group_name = "vmx-security-group"
subnet_cidr_block = "10.66.0.0/26"
vmx_has_public_ip = true
vmx_instance_name = "vMX-instance"
vmx_instance_type = "c5.large"
vmx_license_size = "medium"
vpc_cidr_block = "10.66.0.0/24"
```

## Usage
### 1. Run _terraform init_
```
yujiterada@mac terraform-vmx-basic % terraform init

Initializing the backend...
Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of cisco-open/meraki from the dependency lock file
- Using previously-installed hashicorp/aws v5.56.1
- Using previously-installed cisco-open/meraki v0.2.5-alpha

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```


### 2. Run _terraform apply_
```
yujiterada@mac terraform-vmx-basic % terraform apply -var="meraki_dashboard_api_key=$MERAKI_DASHBOARD_API_KEY"
module.aws_vmx.data.aws_ami.marketplace_vmx: Reading...
module.aws_vmx.data.aws_ami.marketplace_vmx: Read complete after 2s [id=ami-094d363fc83c2d454]

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.aws_subnet_public.aws_route_table.public_rt will be created
  + resource "aws_route_table" "public_rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags_all         = (known after apply)
      + vpc_id           = (known after apply)
    }

  # module.aws_subnet_public.aws_route_table_association.public_rta will be created
  + resource "aws_route_table_association" "public_rta" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.aws_subnet_public.aws_subnet.subnet will be created
  + resource "aws_subnet" "subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = (known after apply)
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.66.0.0/26"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags_all                                       = (known after apply)
      + vpc_id                                         = (known after apply)
    }

  # module.aws_vmx.aws_instance.ec2_instance will be created
  + resource "aws_instance" "ec2_instance" {
      + ami                                  = "ami-094d363fc83c2d454"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "c5.large"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = false
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags_all                             = (known after apply)
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + root_block_device {
          + delete_on_termination = true
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags_all              = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = 10
          + volume_type           = "gp2"
        }
    }

  # module.aws_vmx.aws_security_group.vmx_sg will be created
  + resource "aws_security_group" "vmx_sg" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "vmx-security-group"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # module.aws_vpc_igw.aws_internet_gateway.igw will be created
  + resource "aws_internet_gateway" "igw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags_all = (known after apply)
      + vpc_id   = (known after apply)
    }

  # module.aws_vpc_igw.aws_vpc.vpc will be created
  + resource "aws_vpc" "vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.66.0.0/24"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = (known after apply)
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags_all                             = (known after apply)
    }

  # module.meraki_network_vmx.meraki_devices_appliance_vmx_authentication_token.vmx_token will be created
  + resource "meraki_devices_appliance_vmx_authentication_token" "vmx_token" {
      + item   = (known after apply)
      + serial = (known after apply)
    }

  # module.meraki_network_vmx.meraki_networks.vmx_network will be created
  + resource "meraki_networks" "vmx_network" {
      + enrollment_string           = (known after apply)
      + id                          = (known after apply)
      + is_bound_to_config_template = (known after apply)
      + name                        = "AWS"
      + network_id                  = (known after apply)
      + notes                       = (known after apply)
      + organization_id             = "734417"
      + product_types               = [
          + "appliance",
        ]
      + tags                        = (known after apply)
      + time_zone                   = (known after apply)
      + url                         = (known after apply)
    }

  # module.meraki_network_vmx.meraki_networks_devices_claim_vmx.vmx will be created
  + resource "meraki_networks_devices_claim_vmx" "vmx" {
      + item       = (known after apply)
      + network_id = (known after apply)
      + parameters = {
          + size = "medium"
        }
    }

  # module.meraki_passthrough_hub.meraki_networks_appliance_settings.passthrough will be created
  + resource "meraki_networks_appliance_settings" "passthrough" {
      + client_tracking_method = "MAC address"
      + deployment_mode        = "passthrough"
      + dynamic_dns            = (known after apply)
      + network_id             = (known after apply)
    }

  # module.meraki_passthrough_hub.meraki_networks_appliance_vpn_site_to_site_vpn.hub will be created
  + resource "meraki_networks_appliance_vpn_site_to_site_vpn" "hub" {
      + hubs       = (known after apply)
      + mode       = "hub"
      + network_id = (known after apply)
      + subnets    = (known after apply)
    }

Plan: 12 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + vmx_instance_id        = (known after apply)
  + vmx_instance_public_ip = (known after apply)
  + vmx_token              = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.meraki_network_vmx.meraki_networks.vmx_network: Creating...
module.aws_vpc_igw.aws_vpc.vpc: Creating...
module.meraki_network_vmx.meraki_networks.vmx_network: Creation complete after 3s [id=N_726205439913517636]
module.meraki_passthrough_hub.meraki_networks_appliance_settings.passthrough: Creating...
module.meraki_network_vmx.meraki_networks_devices_claim_vmx.vmx: Creating...
module.meraki_passthrough_hub.meraki_networks_appliance_vpn_site_to_site_vpn.hub: Creating...
module.meraki_passthrough_hub.meraki_networks_appliance_vpn_site_to_site_vpn.hub: Creation complete after 2s
module.aws_vpc_igw.aws_vpc.vpc: Creation complete after 4s [id=vpc-06681a0dfad90235a]
module.aws_vpc_igw.aws_internet_gateway.igw: Creating...
module.aws_subnet_public.aws_subnet.subnet: Creating...
module.aws_vmx.aws_security_group.vmx_sg: Creating...
module.meraki_passthrough_hub.meraki_networks_appliance_settings.passthrough: Creation complete after 2s
module.aws_subnet_public.aws_subnet.subnet: Creation complete after 2s [id=subnet-0388624ac32e6b505]
module.aws_vpc_igw.aws_internet_gateway.igw: Creation complete after 3s [id=igw-0c9300fbc2b9e146c]
module.meraki_network_vmx.meraki_networks_devices_claim_vmx.vmx: Creation complete after 5s
module.meraki_network_vmx.meraki_devices_appliance_vmx_authentication_token.vmx_token: Creating...
module.aws_subnet_public.aws_route_table.public_rt: Creating...
module.meraki_network_vmx.meraki_devices_appliance_vmx_authentication_token.vmx_token: Creation complete after 1s
module.aws_vmx.aws_security_group.vmx_sg: Creation complete after 4s [id=sg-0e15673575ea0e985]
module.aws_vmx.aws_instance.ec2_instance: Creating...
module.aws_subnet_public.aws_route_table.public_rt: Creation complete after 2s [id=rtb-0ae6d68051e075d7e]
module.aws_subnet_public.aws_route_table_association.public_rta: Creating...
module.aws_subnet_public.aws_route_table_association.public_rta: Creation complete after 1s [id=rtbassoc-0898998b9941892ac]
module.aws_vmx.aws_instance.ec2_instance: Still creating... [10s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Creation complete after 16s [id=i-0b30b91ae682f499a]

Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

Outputs:

vmx_instance_id = "i-0b30b91ae682f499a"
vmx_instance_public_ip = "35.95.84.23"
vmx_token = "8ec815670bd7aed2e7ae9bb0e920b468/fe5eb03bc4f5c0809058825c2e65547b4d2f77dcf0606f7f790bb5320b58185bca659bd35bab053d11fc3bcc8c62995c3df2a8fbc8c183c74575bf1519186ac5/e67881a3ce75662bfe157808851c58e30a23dedf405349d622e35c05f5909668"
```
### 3. Manually configure _Local networks_ for vMX

Go to _Security & SD-WAN > Site-to-site VPN > Local networks_ to configure advertised routes from vMX to other MXs.

As of Jul 5 2024, an **API endpoint to configure this configuration doesn't exist** (it works for NAT mode MXs), and therefore, doesn't exist in Terraform as well.

### 4. To delete, run _terraform destroy_
```
yujiterada@mac terraform-vmx-basic % terraform destroy -var="meraki_dashboard_api_key=$MERAKI_DASHBOARD_API_KEY"
module.meraki_network_vmx.meraki_networks.vmx_network: Refreshing state... [id=N_726205439913517636]
module.meraki_network_vmx.meraki_networks_devices_claim_vmx.vmx: Refreshing state...
module.meraki_passthrough_hub.meraki_networks_appliance_vpn_site_to_site_vpn.hub: Refreshing state...
module.meraki_passthrough_hub.meraki_networks_appliance_settings.passthrough: Refreshing state...
module.meraki_network_vmx.meraki_devices_appliance_vmx_authentication_token.vmx_token: Refreshing state...
module.aws_vmx.data.aws_ami.marketplace_vmx: Reading...
module.aws_vpc_igw.aws_vpc.vpc: Refreshing state... [id=vpc-06681a0dfad90235a]
module.aws_vmx.data.aws_ami.marketplace_vmx: Read complete after 2s [id=ami-094d363fc83c2d454]
module.aws_vpc_igw.aws_internet_gateway.igw: Refreshing state... [id=igw-0c9300fbc2b9e146c]
module.aws_subnet_public.aws_subnet.subnet: Refreshing state... [id=subnet-0388624ac32e6b505]
module.aws_vmx.aws_security_group.vmx_sg: Refreshing state... [id=sg-0e15673575ea0e985]
module.aws_subnet_public.aws_route_table.public_rt: Refreshing state... [id=rtb-0ae6d68051e075d7e]
module.aws_vmx.aws_instance.ec2_instance: Refreshing state... [id=i-0b30b91ae682f499a]
module.aws_subnet_public.aws_route_table_association.public_rta: Refreshing state... [id=rtbassoc-0898998b9941892ac]

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.aws_subnet_public.aws_route_table.public_rt will be destroyed
  - resource "aws_route_table" "public_rt" {
      - arn              = "arn:aws:ec2:us-west-2:107524997680:route-table/rtb-0ae6d68051e075d7e" -> null
      - id               = "rtb-0ae6d68051e075d7e" -> null
      - owner_id         = "107524997680" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - core_network_arn           = ""
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = "igw-0c9300fbc2b9e146c"
              - ipv6_cidr_block            = ""
              - local_gateway_id           = ""
              - nat_gateway_id             = ""
              - network_interface_id       = ""
              - transit_gateway_id         = ""
              - vpc_endpoint_id            = ""
              - vpc_peering_connection_id  = ""
            },
        ] -> null
      - tags             = {} -> null
      - tags_all         = {} -> null
      - vpc_id           = "vpc-06681a0dfad90235a" -> null
    }

  # module.aws_subnet_public.aws_route_table_association.public_rta will be destroyed
  - resource "aws_route_table_association" "public_rta" {
      - id             = "rtbassoc-0898998b9941892ac" -> null
      - route_table_id = "rtb-0ae6d68051e075d7e" -> null
      - subnet_id      = "subnet-0388624ac32e6b505" -> null
    }

  # module.aws_subnet_public.aws_subnet.subnet will be destroyed
  - resource "aws_subnet" "subnet" {
      - arn                                            = "arn:aws:ec2:us-west-2:107524997680:subnet/subnet-0388624ac32e6b505" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "us-west-2d" -> null
      - availability_zone_id                           = "usw2-az4" -> null
      - cidr_block                                     = "10.66.0.0/26" -> null
      - enable_dns64                                   = false -> null
      - enable_lni_at_device_index                     = 0 -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-0388624ac32e6b505" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = false -> null
      - owner_id                                       = "107524997680" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {} -> null
      - tags_all                                       = {} -> null
      - vpc_id                                         = "vpc-06681a0dfad90235a" -> null
    }

  # module.aws_vmx.aws_instance.ec2_instance will be destroyed
  - resource "aws_instance" "ec2_instance" {
      - ami                                  = "ami-094d363fc83c2d454" -> null
      - arn                                  = "arn:aws:ec2:us-west-2:107524997680:instance/i-0b30b91ae682f499a" -> null
      - associate_public_ip_address          = true -> null
      - availability_zone                    = "us-west-2d" -> null
      - cpu_core_count                       = 1 -> null
      - cpu_threads_per_core                 = 2 -> null
      - disable_api_stop                     = false -> null
      - disable_api_termination              = false -> null
      - ebs_optimized                        = false -> null
      - get_password_data                    = false -> null
      - hibernation                          = false -> null
      - id                                   = "i-0b30b91ae682f499a" -> null
      - instance_initiated_shutdown_behavior = "stop" -> null
      - instance_state                       = "running" -> null
      - instance_type                        = "c5.large" -> null
      - ipv6_address_count                   = 0 -> null
      - ipv6_addresses                       = [] -> null
      - monitoring                           = false -> null
      - placement_partition_number           = 0 -> null
      - primary_network_interface_id         = "eni-0ad727f5fb41c428e" -> null
      - private_dns                          = "ip-10-66-0-48.us-west-2.compute.internal" -> null
      - private_ip                           = "10.66.0.48" -> null
      - public_ip                            = "35.95.84.23" -> null
      - secondary_private_ips                = [] -> null
      - security_groups                      = [] -> null
      - source_dest_check                    = false -> null
      - subnet_id                            = "subnet-0388624ac32e6b505" -> null
      - tags                                 = {} -> null
      - tags_all                             = {} -> null
      - tenancy                              = "default" -> null
      - user_data                            = "f0ae2dd9686e772413e6e3c1d2547f78e6cad7d7" -> null
      - user_data_replace_on_change          = false -> null
      - vpc_security_group_ids               = [
          - "sg-0e15673575ea0e985",
        ] -> null

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      - cpu_options {
          - core_count       = 1 -> null
          - threads_per_core = 2 -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - maintenance_options {
          - auto_recovery = "default" -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_protocol_ipv6          = "disabled" -> null
          - http_put_response_hop_limit = 1 -> null
          - http_tokens                 = "optional" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - private_dns_name_options {
          - enable_resource_name_dns_a_record    = false -> null
          - enable_resource_name_dns_aaaa_record = false -> null
          - hostname_type                        = "ip-name" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/xvda" -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - tags                  = {} -> null
          - tags_all              = {} -> null
          - throughput            = 0 -> null
          - volume_id             = "vol-0c5be9ee27bc3ce2b" -> null
          - volume_size           = 10 -> null
          - volume_type           = "gp2" -> null
        }
    }

  # module.aws_vmx.aws_security_group.vmx_sg will be destroyed
  - resource "aws_security_group" "vmx_sg" {
      - arn                    = "arn:aws:ec2:us-west-2:107524997680:security-group/sg-0e15673575ea0e985" -> null
      - description            = "Managed by Terraform" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - id                     = "sg-0e15673575ea0e985" -> null
      - ingress                = [] -> null
      - name                   = "vmx-security-group" -> null
      - owner_id               = "107524997680" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {} -> null
      - tags_all               = {} -> null
      - vpc_id                 = "vpc-06681a0dfad90235a" -> null
    }

  # module.aws_vpc_igw.aws_internet_gateway.igw will be destroyed
  - resource "aws_internet_gateway" "igw" {
      - arn      = "arn:aws:ec2:us-west-2:107524997680:internet-gateway/igw-0c9300fbc2b9e146c" -> null
      - id       = "igw-0c9300fbc2b9e146c" -> null
      - owner_id = "107524997680" -> null
      - tags     = {} -> null
      - tags_all = {} -> null
      - vpc_id   = "vpc-06681a0dfad90235a" -> null
    }

  # module.aws_vpc_igw.aws_vpc.vpc will be destroyed
  - resource "aws_vpc" "vpc" {
      - arn                                  = "arn:aws:ec2:us-west-2:107524997680:vpc/vpc-06681a0dfad90235a" -> null
      - assign_generated_ipv6_cidr_block     = false -> null
      - cidr_block                           = "10.66.0.0/24" -> null
      - default_network_acl_id               = "acl-049aa5829e5fd31e8" -> null
      - default_route_table_id               = "rtb-091e2871874531ab2" -> null
      - default_security_group_id            = "sg-0e2833719a9779ff4" -> null
      - dhcp_options_id                      = "dopt-0693b537adf84159a" -> null
      - enable_dns_hostnames                 = false -> null
      - enable_dns_support                   = true -> null
      - enable_network_address_usage_metrics = false -> null
      - id                                   = "vpc-06681a0dfad90235a" -> null
      - instance_tenancy                     = "default" -> null
      - ipv6_netmask_length                  = 0 -> null
      - main_route_table_id                  = "rtb-091e2871874531ab2" -> null
      - owner_id                             = "107524997680" -> null
      - tags                                 = {} -> null
      - tags_all                             = {} -> null
    }

  # module.meraki_network_vmx.meraki_devices_appliance_vmx_authentication_token.vmx_token will be destroyed
  - resource "meraki_devices_appliance_vmx_authentication_token" "vmx_token" {
      - item   = {
          - expires_at = "2024-07-05T05:24:26Z" -> null
          - token      = "8ec815670bd7aed2e7ae9bb0e920b468/fe5eb03bc4f5c0809058825c2e65547b4d2f77dcf0606f7f790bb5320b58185bca659bd35bab053d11fc3bcc8c62995c3df2a8fbc8c183c74575bf1519186ac5/e67881a3ce75662bfe157808851c58e30a23dedf405349d622e35c05f5909668" -> null
        } -> null
      - serial = "Q2DZ-QKY7-25R9" -> null
    }

  # module.meraki_network_vmx.meraki_networks.vmx_network will be destroyed
  - resource "meraki_networks" "vmx_network" {
      - id                          = "N_726205439913517636" -> null
      - is_bound_to_config_template = false -> null
      - name                        = "AWS" -> null
      - network_id                  = "N_726205439913517636" -> null
      - organization_id             = "734417" -> null
      - product_types               = [
          - "appliance",
        ] -> null
      - time_zone                   = "America/Los_Angeles" -> null
      - url                         = "https://n290.meraki.com/AWS/n/fqBdGaIe/manage/usage/list" -> null
    }

  # module.meraki_network_vmx.meraki_networks_devices_claim_vmx.vmx will be destroyed
  - resource "meraki_networks_devices_claim_vmx" "vmx" {
      - item       = {
          - address      = "" -> null
          - details      = [] -> null
          - firmware     = "Not running configured version" -> null
          - imei         = "" -> null
          - lan_ip       = "" -> null
          - lat          = 37.4180951010362 -> null
          - lng          = -122.098531723022 -> null
          - mac          = "cc:03:d9:01:00:52" -> null
          - model        = "VMX-M" -> null
          - name         = "" -> null
          - network_id   = "N_726205439913517636" -> null
          - notes        = "" -> null
          - product_type = "" -> null
          - serial       = "Q2DZ-QKY7-25R9" -> null
        } -> null
      - network_id = "N_726205439913517636" -> null
      - parameters = {
          - size = "medium" -> null
        } -> null
    }

  # module.meraki_passthrough_hub.meraki_networks_appliance_settings.passthrough will be destroyed
  - resource "meraki_networks_appliance_settings" "passthrough" {
      - client_tracking_method = "MAC address" -> null
      - deployment_mode        = "passthrough" -> null
      - dynamic_dns            = {
          - enabled = true -> null
          - prefix  = "aws" -> null
          - url     = "aws-jbhrvbbdddc.dynamic-m.com" -> null
        } -> null
      - network_id             = "N_726205439913517636" -> null
    }

  # module.meraki_passthrough_hub.meraki_networks_appliance_vpn_site_to_site_vpn.hub will be destroyed
  - resource "meraki_networks_appliance_vpn_site_to_site_vpn" "hub" {
      - hubs       = [] -> null
      - mode       = "hub" -> null
      - network_id = "N_726205439913517636" -> null
      - subnets    = [] -> null
    }

Plan: 0 to add, 0 to change, 12 to destroy.

Changes to Outputs:
  - vmx_instance_id        = "i-0b30b91ae682f499a" -> null
  - vmx_instance_public_ip = "35.95.84.23" -> null
  - vmx_token              = "8ec815670bd7aed2e7ae9bb0e920b468/fe5eb03bc4f5c0809058825c2e65547b4d2f77dcf0606f7f790bb5320b58185bca659bd35bab053d11fc3bcc8c62995c3df2a8fbc8c183c74575bf1519186ac5/e67881a3ce75662bfe157808851c58e30a23dedf405349d622e35c05f5909668" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.meraki_passthrough_hub.meraki_networks_appliance_settings.passthrough: Destroying...
module.meraki_passthrough_hub.meraki_networks_appliance_vpn_site_to_site_vpn.hub: Destroying...
module.meraki_passthrough_hub.meraki_networks_appliance_settings.passthrough: Destruction complete after 0s
module.meraki_passthrough_hub.meraki_networks_appliance_vpn_site_to_site_vpn.hub: Destruction complete after 0s
module.aws_subnet_public.aws_route_table_association.public_rta: Destroying... [id=rtbassoc-0898998b9941892ac]
module.aws_vmx.aws_instance.ec2_instance: Destroying... [id=i-0b30b91ae682f499a]
module.aws_subnet_public.aws_route_table_association.public_rta: Destruction complete after 1s
module.aws_subnet_public.aws_route_table.public_rt: Destroying... [id=rtb-0ae6d68051e075d7e]
module.aws_subnet_public.aws_route_table.public_rt: Destruction complete after 2s
module.aws_vpc_igw.aws_internet_gateway.igw: Destroying... [id=igw-0c9300fbc2b9e146c]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 10s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 10s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 20s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 20s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 30s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 30s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 40s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 40s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 50s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 50s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 1m0s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 1m0s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 1m10s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 1m10s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 1m20s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 1m20s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 1m30s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 1m30s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 1m40s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 1m40s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 1m50s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 1m50s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 2m0s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 2m0s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 2m10s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 2m10s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 2m20s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 2m20s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 2m30s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 2m30s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 2m40s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 2m40s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 2m50s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 2m50s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 3m0s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 3m0s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 3m10s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 3m10s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 3m20s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 3m20s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 3m30s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 3m30s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 3m40s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 3m40s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 3m50s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 3m50s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 4m0s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 4m0s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 4m10s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 4m10s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 4m20s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 4m20s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 4m30s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Still destroying... [id=igw-0c9300fbc2b9e146c, 4m30s elapsed]
module.aws_vpc_igw.aws_internet_gateway.igw: Destruction complete after 4m33s
module.aws_vmx.aws_instance.ec2_instance: Still destroying... [id=i-0b30b91ae682f499a, 4m40s elapsed]
module.aws_vmx.aws_instance.ec2_instance: Destruction complete after 4m43s
module.aws_subnet_public.aws_subnet.subnet: Destroying... [id=subnet-0388624ac32e6b505]
module.aws_vmx.aws_security_group.vmx_sg: Destroying... [id=sg-0e15673575ea0e985]
module.meraki_network_vmx.meraki_devices_appliance_vmx_authentication_token.vmx_token: Destroying...
module.meraki_network_vmx.meraki_devices_appliance_vmx_authentication_token.vmx_token: Destruction complete after 0s
module.meraki_network_vmx.meraki_networks_devices_claim_vmx.vmx: Destroying...
module.meraki_network_vmx.meraki_networks_devices_claim_vmx.vmx: Destruction complete after 0s
module.meraki_network_vmx.meraki_networks.vmx_network: Destroying... [id=N_726205439913517636]
module.aws_subnet_public.aws_subnet.subnet: Destruction complete after 0s
module.aws_vmx.aws_security_group.vmx_sg: Destruction complete after 1s
module.aws_vpc_igw.aws_vpc.vpc: Destroying... [id=vpc-06681a0dfad90235a]
module.aws_vpc_igw.aws_vpc.vpc: Destruction complete after 1s
module.meraki_network_vmx.meraki_networks.vmx_network: Destruction complete after 3s
╷
│ Warning: Error deleting NetworksApplianceVpnSiteToSiteVpn
│ 
│ This resource has no delete method in the meraki lab, the resource was deleted only in terraform.
╵
╷
│ Warning: Error deleting Resource
│ 
│ This resource has no delete method in the meraki lab, the resource was deleted only in terraform.
╵
╷
│ Warning: Error deleting NetworksApplianceSettings
│ 
│ This resource has no delete method in the meraki lab, the resource was deleted only in terraform.
╵
╷
│ Warning: Error deleting Resource
│ 
│ This resource has no delete method in the meraki lab, the resource was deleted only in terraform.
╵

Destroy complete! Resources: 12 destroyed.
yujterad@mac terraform-vmx-basic % terraform init

Initializing the backend...
Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of cisco-open/meraki from the dependency lock file
- Using previously-installed hashicorp/aws v5.56.1
- Using previously-installed cisco-open/meraki v0.2.5-alpha

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
