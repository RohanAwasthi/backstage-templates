
output "id" {
  description = "ID of public ip"
  value       = azurerm_public_ip.public_ip.id
}

output "ip_address" {
  description = "Public IP address"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "fqdn" {
  description = "Fully qualified domain name of the A DNS record associated with the public IP. domain_name_label must be specified to get the fqdn. This is the concatenation of the domain_name_label and the regionalized DNS zone."
  value       = azurerm_public_ip.public_ip.fqdn
}
