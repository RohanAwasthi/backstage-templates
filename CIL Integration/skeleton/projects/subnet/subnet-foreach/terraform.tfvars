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
  },
  "vnet-3" = {
    address_space = ["10.2.0.0/16"]
    tags = {
      contact_name     = "Mitali Ghoshal"
      contact_email    = "Mitali.Ghoshal@gds.ey.com"
      project          = "CLOUDIFY"
      region           = "South India"
      Application_name = "Dev"
    }
  },
  "vnet-2" = {
    address_space = ["10.1.0.0/16"]
    tags = {
      contact_name     = "Mitali Ghoshal"
      contact_email    = "Mitali.Ghoshal@gds.ey.com"
      project          = "CLOUDIFY"
      region           = "South India"
      Application_name = "Dev"
    }
  }
}

subnets = {
  "s-1_v-1" = {
    name                                          = "s-1"
    virtual_network_name                          = "vnet-1"
    private_endpoint_network_policies_enabled     = true
    private_link_service_network_policies_enabled = true
    address_prefixes                              = ["10.0.0.0/24"]
    delegation = [{
      name = "delegation"
      service_delegation = {
        name    = "Microsoft.ContainerInstance/containerGroups"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    }]
  },
  "s-3_v-1" = {
    name                                          = "s-3"
    virtual_network_name                          = "vnet-1"
    private_endpoint_network_policies_enabled     = true
    private_link_service_network_policies_enabled = true
    address_prefixes                              = ["10.0.2.0/24"]
  },
  "s-2_v-1" = {
    name                                          = "s-2"
    virtual_network_name                          = "vnet-1"
    private_endpoint_network_policies_enabled     = true
    private_link_service_network_policies_enabled = true
    address_prefixes                              = ["10.0.1.0/24"]
  },
  "s-1_v-2" = {
    name                                          = "s-1"
    virtual_network_name                          = "vnet-2"
    private_endpoint_network_policies_enabled     = true
    private_link_service_network_policies_enabled = true
    address_prefixes                              = ["10.1.0.0/24"]
  },
  "s-3_v-2" = {
    private_endpoint_network_policies_enabled     = true
    private_link_service_network_policies_enabled = true
    address_prefixes                              = ["10.1.2.0/24"]
    name                                          = "s-3"
    virtual_network_name                          = "vnet-2"
  },
  "s-2_v-2" = {
    name                                          = "s-2"
    virtual_network_name                          = "vnet-2"
    private_endpoint_network_policies_enabled     = true
    private_link_service_network_policies_enabled = true
    address_prefixes                              = ["10.1.1.0/24"]
  }
}