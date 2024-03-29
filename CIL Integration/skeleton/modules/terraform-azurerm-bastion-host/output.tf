output "id" {
  value       = azurerm_bastion_host.bastion_host.id
  description = "The ID of the Bastion Host."
}

output "dns_name" {
  value       = azurerm_bastion_host.bastion_host.dns_name
  description = "The FQDN for the Bastion Host."
}
