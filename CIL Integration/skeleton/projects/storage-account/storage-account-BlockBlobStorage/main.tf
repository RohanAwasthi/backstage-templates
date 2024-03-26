module "storageacc" {

  source                            = "../../../modules/terraform-azurerm-storage-account"
  location                          = module.resource_group.location
  resource_group_name               = module.resource_group.name
  length                            = var.length
  special                           = var.special
  upper                             = var.upper
  name                              = var.name
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  min_tls_version                   = var.min_tls_version
  tags                              = var.tags
  account_kind                      = var.account_kind
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  access_tier                       = var.access_tier
  public_network_access_enabled     = var.public_network_access_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  edge_zone                         = var.edge_zone
  enable_https_traffic_only         = var.enable_https_traffic_only
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  shared_access_key_enabled         = var.shared_access_key_enabled
  is_hns_enabled                    = var.is_hns_enabled
  nfsv3_enabled                     = var.nfsv3_enabled
  large_file_share_enabled          = var.large_file_share_enabled
  custom_domain                     = var.custom_domain
  customer_managed_key              = var.customer_managed_key
  identity                          = var.identity
  managed_identity_type             = var.managed_identity_type
  enable_static_website             = var.enable_static_website
  enable_share_properties           = var.enable_share_properties
  cors_rule                         = var.cors_rule
  retention_policy                  = var.retention_policy
  smb                               = var.smb
  azure_files_authentication        = var.azure_files_authentication
  active_directory                  = var.active_directory
  enable_routing                    = var.enable_routing
  routing                           = var.routing
  blob_properties                   = var.blob_properties
  cors_rule_blob                    = var.cors_rule_blob
  enable_blob_properties            = var.enable_blob_properties
  delete_retention_policy           = var.delete_retention_policy
  container_delete_retention_policy = var.container_delete_retention_policy
  queue_properties                  = var.queue_properties
  cors_rule_queue                   = var.cors_rule_queue
  logging                           = var.logging
  minute_metrics                    = var.minute_metrics
  hour_metrics                      = var.hour_metrics
  network_rule_default_action       = var.network_rule_default_action
  ip_rules                          = var.ip_rules
  subnet_ids                        = var.subnet_ids
  bypass                            = var.bypass
  private_link_access               = var.private_link_access
  network_rules_enabled             = var.network_rules_enabled
  encryption_scopes                 = var.encryption_scopes
  enable_advanced_threat_protection = var.enable_advanced_threat_protection
  queue_encryption_key_type         = var.queue_encryption_key_type
  table_encryption_key_type         = var.table_encryption_key_type
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
}


module "resource_group" {
  source                = "../../../modules/terraform-azure-resource-group/"
  create_resource_group = var.create_resource_group
  name                  = var.resource_group_name
  location              = var.location
  tags                  = var.tags
}

module "private_endpoint" {
  count                             = var.create_private-endpoint ? 1 : 0
  source                            = "../../../modules/terraform-azurerm-private-endpoint"
  resource_group_name               = module.resource_group.name
  location                          = module.resource_group.location
  subnet_id                         = var.subnet_id
  tags                              = var.tags
  private_endpoint_name             = var.private_endpoint_name
  private_service_connection_name   = var.private_service_connection_name
  subresource_names                 = var.subresource_names
  is_manual_connection              = var.is_manual_connection
  request_message                   = var.request_message
  private_dns_zone_group            = var.private_dns_zone_group
  private_connection_resource_alias = var.private_connection_resource_alias
  private_connection_resource_id    = module.storageacc.storage_id
  ip_configuration                  = var.ip_configuration
  custom_network_interface_name     = var.custom_network_interface_name
}


