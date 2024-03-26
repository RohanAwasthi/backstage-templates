output "subnet_name_and_subnet_id" {
  value       = local.subnet_name_and_subnet_id
  description = "Subnet Id with respective Subnet Name(subnet_name-virtual_network_name)."
}

output "subnet_name" {
  value       = local.subnet_name
  description = "List of Subnet names."
}

output "subnet_id" {
  value       = local.subnet_id
  description = "List of Subnet Ids"
}
