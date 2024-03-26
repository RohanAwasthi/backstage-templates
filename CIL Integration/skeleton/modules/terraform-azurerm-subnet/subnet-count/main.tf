resource "azurerm_subnet" "subnet" {
  count                                         = length(var.subnets)
  name                                          = var.subnets[count.index].name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.subnets[count.index].virtual_network_name
  address_prefixes                              = var.subnets[count.index].address_prefixes
  service_endpoints                             = var.subnets[count.index].service_endpoints
  private_endpoint_network_policies_enabled     = var.subnets[count.index].private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.subnets[count.index].private_link_service_network_policies_enabled
  service_endpoint_policy_ids                   = var.subnets[count.index].service_endpoint_policy_ids
  dynamic "delegation" {
    for_each = var.subnets[count.index].delegation != null ? { for i, d in var.subnets[count.index].delegation : i => d } : {}
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
    "${s.name}_${s.virtual_network_name}" => s.id
  }
}
