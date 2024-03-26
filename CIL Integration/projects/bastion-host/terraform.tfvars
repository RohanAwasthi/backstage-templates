create_resource_group = true
resource_group_name   = "cloudifyrgmit"
location              = "South India"
tags = {
  contact_name     = "Mitali Ghoshal"
  contact_email    = "Mitali.Ghoshal@gds.ey.com"
  project          = "CLOUDIFY"
  region           = "South India"
  Application_name = "Dev"
}

create_virtual_network = true
vnet = {
  "vnet-1" = {
    address_space = ["10.0.0.0/16"]
    tags = {
      contact_name     = "Mitali Ghoshal"
      contact_email    = "Mitali.Ghoshal@gds.ey.com"
      project          = "CLOUDIFY"
      region           = "South India"
      Application_name = "Dev"
    }
  }
}

create_subnet = true
subnets = {
  "AzureBastionSubnet" = {
    name                                          = "AzureBastionSubnet"
    virtual_network_name                          = "vnet-1"
    private_endpoint_network_policies_enabled     = true
    private_link_service_network_policies_enabled = true
    address_prefixes                              = ["10.0.0.0/24"]
  }
}

create_public_ip = true
public_ip_name        = "pip123"
allocation_method     = "Static"
pip_sku = "Standard"

name           = "bastion-mitali1"
copy_paste_enabled     = true
file_copy_enabled      = false
sku                    = "Standard" #defaults to Basic
ip_connect_enabled     = true
scale_units            = 2
shareable_link_enabled = true
tunneling_enabled      = true

ip_name           = "vn-001-ip"

###  properties below are optional and can be set according to the requirement  ###

ip_version              = "IPv4" #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
domain_name_label       = "testip1-dns"
idle_timeout_in_minutes = null #TCP timeout for idle connections. The value can be set between 4 and 30 minutes.
reverse_fqdn            = null
public_ip_prefix_id     = null #ID of public_ip_prefix 

### refer to the prefix and check sku types are same in IP and prefix

edge_zone               = null
sku_tier                = "Regional"
ddos_protection_mode    = "Disabled" #Defaults to VirtualNetworkInherited
ddos_protection_plan_id = null       #ddos_protection_plan_id can only be set when ddos_protection_mode is Enabled

# subnet_id            = "/subscriptions/dcd2c118-9f88-4a53-8b1b-fbc235ad0bef/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vn-001/subnets/AzureBastionSubnet"
# public_ip_address_id = "/subscriptions/dcd2c118-9f88-4a53-8b1b-fbc235ad0bef/resourceGroups/rg/providers/Microsoft.Network/publicIPAddresses/publicip-mitali"
