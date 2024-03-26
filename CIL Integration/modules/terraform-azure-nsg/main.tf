#------------------------------------------Network Security Group---------------------------------------------#
locals {

  list_of_csv_lines = csvdecode(file(var.csv_file_name_for_NSG))
  all_nsg_names     = distinct([for item in local.list_of_csv_lines : item.nsg_name])

  combine = {
    for item in local.all_nsg_names :
    "${item}" => [
      for line in local.list_of_csv_lines : line
      if item == line.nsg_name
    ]
  }
    nsg_name_and_nsg_id = {
    for index, nsg in azurerm_network_security_group.nsg :
    nsg.name => nsg.id
  }
}

resource "azurerm_network_security_group" "nsg" {
  for_each = local.combine
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  dynamic "security_rule" {
    for_each = each.value

    content {
      name                       = security_rule.value.rulename
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
  tags = var.tags
}
