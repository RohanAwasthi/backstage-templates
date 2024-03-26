resource "azurerm_subnet" "subnet" {
  for_each                                      = var.subnets
  name                                          = each.value.name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = each.value.virtual_network_name
  address_prefixes                              = each.value.address_prefixes
  service_endpoints                             = each.value.service_endpoints
  private_endpoint_network_policies_enabled     = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  service_endpoint_policy_ids                   = each.value.service_endpoint_policy_ids
  dynamic "delegation" {
    for_each = each.value.delegation != null ? { for i, d in each.value.delegation : i => d } : {}
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}


locals {
  subnet_name_and_subnet_id = {
    for index, s in azurerm_subnet.subnet :
    "${s.name}-${s.virtual_network_name}" => s.id
  }
  subnet_name = [
    for n in azurerm_subnet.subnet : n.name
  ]
  subnet_id = [
    for n in azurerm_subnet.subnet : n.id
  ]
}
