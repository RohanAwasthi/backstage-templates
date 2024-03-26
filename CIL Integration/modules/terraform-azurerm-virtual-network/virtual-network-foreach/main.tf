resource "azurerm_virtual_network" "vn" {
  for_each                = var.vnet
  location                = var.location
  resource_group_name     = var.resource_group_name
  name                    = each.key
  address_space           = each.value.address_space
  bgp_community           = each.value.bgp_community
  dns_servers             = each.value.dns_servers
  edge_zone               = each.value.edge_zone
  flow_timeout_in_minutes = each.value.flow_timeout_in_minutes
  dynamic "ddos_protection_plan" {
    for_each = lookup(each.value, "ddos_protection_plan") != null ? [1] : []
    content {
      id     = each.value.id
      enable = each.value.enable
    }
  }
  dynamic "encryption" {
    for_each = lookup(each.value, "encryption") != null ? [1] : []
    content {
      enforcement = each.value.enforcement
    }
  }
  tags = each.value.tags
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
