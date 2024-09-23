#----------------------------------------------Locals---------------------------------------------#
locals {
  resource_group_id = element(coalescelist(data.azurerm_resource_group.rgrp.*.id, azurerm_resource_group.rg.*.id, [""]), 0)
}

output "name" {
  description = "Resource group name"
  value       = local.resource_group_name
}

output "location" {
  description = "Resource group location"
  value       = local.location
}

output "id" {
  description = "Resource group ID"
  value       = local.resource_group_id
}
