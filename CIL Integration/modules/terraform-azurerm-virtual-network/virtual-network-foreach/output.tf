output "vnet_name_and_vnet_id" {
  value       = local.vnet_name_and_vnet_id
  description = "Map of Vnet IDs with respective to Vnet name."
}

output "vnet_name_and_vnet_guid" {
  value       = local.vnet_name_and_vnet_guid
  description = "Map of Vnet GUIDs with respective to Vnet name."
}
