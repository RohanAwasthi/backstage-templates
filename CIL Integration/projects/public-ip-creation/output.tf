output "name" {
  description = "Resource group name"
  value       = module.resource_group.name
}

output "location" {
  description = "Resource group location"
  value       = module.resource_group.location
}

output "fqdn" {
  description = "Public IP FQDN"
  value       = module.public_ip.fqdn
}

output "ip_address" {
  description = "Public IP address"
  value       = module.public_ip.ip_address
}

output "id" {
  description = "Public IP ID"
  value       = module.public_ip.id
}
