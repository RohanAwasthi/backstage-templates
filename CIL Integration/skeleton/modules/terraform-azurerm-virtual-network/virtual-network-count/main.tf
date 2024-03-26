resource "azurerm_virtual_network" "vn" {
  count                   = length(var.vnet)
  location                = var.location
  resource_group_name     = var.resource_group_name
  name                    = var.vnet[count.index].name
  address_space           = var.vnet[count.index].address_space
  bgp_community           = var.vnet[count.index].bgp_community
  dns_servers             = var.vnet[count.index].dns_servers
  edge_zone               = var.vnet[count.index].edge_zone
  flow_timeout_in_minutes = var.vnet[count.index].flow_timeout_in_minutes
  dynamic "ddos_protection_plan" {
    for_each = lookup(var.vnet[count.index], "ddos_protection_plan") != null ? [1] : []
    content {
      id     = var.vnet[count.index].ddos_protection_plan.id
      enable = var.vnet[count.index].ddos_protection_plan.enable
    }
  }
  dynamic "encryption" {
    for_each = lookup(var.vnet[count.index], "encryption") != null ? [1] : []
    content {
      enforcement = var.vnet[count.index].encryption.enforcement
    }
  }
  tags = var.vnet[count.index].tags
}


locals {
  vnet_name_and_vnet_id = {
    for index, vnet in azurerm_virtual_network.vn :
    vnet.name => vnet.id
  }
}

locals {
  vnet_name_and_vnet_guid = {
    for index, vnet in azurerm_virtual_network.vn :
    vnet.name => vnet.guid
  }
}
