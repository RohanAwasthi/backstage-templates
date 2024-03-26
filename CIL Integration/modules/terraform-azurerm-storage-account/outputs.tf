
output "storage_id" {
  description = "The name of the resource group in which resources are created"
  value       = azurerm_storage_account.sa.id
}
output "storage_primary_location" {
  description = "The primary location of the storage account."
  value       = azurerm_storage_account.sa.primary_location
}
output "storage_secondary_location" {
  description = "The secondary location of the storage account."
  value       = azurerm_storage_account.sa.secondary_location
}
output "storage_primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}
output "storage_primary_blob_host" {
  description = "The hostname with port if applicable for blob storage in the primary location."
  value       = azurerm_storage_account.sa.primary_blob_host 
}
output "storage_secondary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_blob_endpoint
}
output "storage_secondary_blob_host" {
  description = "The hostname with port if applicable for blob storage in the secondary location"
  value       = azurerm_storage_account.sa.secondary_blob_host
}
output "storage_primary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the primary location."
  value       = azurerm_storage_account.sa.primary_queue_endpoint
}
output "storage_primary_queue_host" {
  description = "The hostname with port if applicable for queue storage in the primary location."
  value       = azurerm_storage_account.sa.primary_queue_host
}
output "storage_secondary_queue_endpoint" {
  description = " The endpoint URL for queue storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_queue_endpoint
}
output "storage_secondary_queue_host" {
  description = "The hostname with port if applicable for queue storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_queue_host 
}
output "storage_primary_table_endpoint" {
  description = "The endpoint URL for table storage in the primary location."
  value       = azurerm_storage_account.sa.primary_table_endpoint
}
output "storage_primary_table_host" {
  description = "The hostname with port if applicable for table storage in the primary location."
  value       = azurerm_storage_account.sa.primary_table_host
}
output "storage_secondary_table_endpoint" {
  description = "The endpoint URL for table storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_table_endpoint
}
output "storage_secondary_table_host" {
  description = "The hostname with port if applicable for table storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_table_host
}
output "storage_primary_file_endpoint" {
  description = "The endpoint URL for file storage in the primary location."
  value       = azurerm_storage_account.sa.primary_file_endpoint
}
output "storage_primary_file_host" {
  description = "The hostname with port if applicable for file storage in the primary location."
  value       = azurerm_storage_account.sa.primary_file_host
}
output "storage_secondary_file_endpoint" {
  description = "The endpoint URL for file storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_file_endpoint
}
output "storage_secondary_file_host" {
  description = "The hostname with port if applicable for file storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_file_host
}
output "storage_primary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the primary location."
  value       = azurerm_storage_account.sa.primary_dfs_endpoint
}
output "storage_primary_dfs_host" {
  description = "The hostname with port if applicable for DFS storage in the primary location."
  value       = azurerm_storage_account.sa.primary_dfs_host
}
output "storage_secondary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_dfs_endpoint
}
output "storage_secondary_dfs_host" {
  description = "The hostname with port if applicable for DFS storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_dfs_host
}
output "storage_primary_web_endpoint" {
  description = "The endpoint URL for web storage in the primary location."
  value       = azurerm_storage_account.sa.primary_web_endpoint
}
output "storage_primary_web_host" {
  description = "The hostname with port if applicable for web storage in the primary location."
  value       = azurerm_storage_account.sa.primary_web_host
}
output "storage_secondary_web_endpoint" {
  description = "The endpoint URL for web storage in the secondary location"
  value       = azurerm_storage_account.sa.secondary_web_endpoint
}
output "storage_secondary_web_host" {
  description = "The hostname with port if applicable for web storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_web_host
}
output "storage_primary_access_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.sa.primary_access_key
}
output "storage_secondary_access_key" {
  description = "The secondary access key for the storage account."
  value       = azurerm_storage_account.sa.secondary_access_key
}
output "storage_primary_connection_string" {
  description = "The connection string associated with the primary location."
  value       = azurerm_storage_account.sa.primary_connection_string
}
output "storage_secondary_connection_string" {
  description = "The connection string associated with the secondary location"
  value       = azurerm_storage_account.sa.secondary_connection_string
}
output "storage_primary_blob_connection_string" {
  description = "The connection string associated with the primary blob location."
  value       = azurerm_storage_account.sa.primary_blob_connection_string
}
output "storage_secondary_blob_connection_string" {
  description = "The connection string associated with the secondary blob location."
  value       = azurerm_storage_account.sa.secondary_blob_connection_string
}

