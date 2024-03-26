
locals {

  is_hns_enabled = var.account_tier == "Standard" || (var.account_tier == "Premium" && var.account_kind == "BlockBlobStorage") && var.is_hns_enabled ? true : false

}

resource "random_string" "unique" {
  length  = var.length
  special = var.special
  upper   = var.upper
}
#---------------------------------------------------Storage account-------------------------------------------------------#

resource "azurerm_storage_account" "sa" {
  name                             = substr(format("sta%s%s", lower(replace(var.name, "/[[:^alnum:]]/", "")), random_string.unique.result), 0, 24)   
  resource_group_name              = var.resource_group_name
  location                         = var.location
  account_tier                     = var.account_tier # Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid
  account_replication_type         = var.account_replication_type
  min_tls_version                  = var.min_tls_version
  tags                             = merge({ "ResourceName" = substr(format("sta%s%s", lower(replace(var.name, "/[[:^alnum:]]/", "")), random_string.unique.result), 0, 24) }, var.tags, )
  account_kind                     = var.account_kind
  public_network_access_enabled    = var.public_network_access_enabled
  default_to_oauth_authentication  = var.default_to_oauth_authentication
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  access_tier                      = var.access_tier
  edge_zone                        = var.edge_zone
  enable_https_traffic_only        = var.enable_https_traffic_only
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  shared_access_key_enabled        = var.shared_access_key_enabled
  is_hns_enabled                   = local.is_hns_enabled
  nfsv3_enabled                    = var.nfsv3_enabled 
  large_file_share_enabled         = var.large_file_share_enabled
  queue_encryption_key_type        = var.queue_encryption_key_type
  table_encryption_key_type        = var.table_encryption_key_type
  infrastructure_encryption_enabled  = var.infrastructure_encryption_enabled 

  dynamic "custom_domain" {
    for_each = var.custom_domain == null ? var.custom_domain : []
    content {
      name                       = custom_domain.value.custom_domain_name
      use_subdomain              = custom_domain.value.use_subdomain
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.account_kind == "StorageV2" && var.access_tier == "Premium" && var.managed_identity_type == "UserAssigned" && var.customer_managed_key != null ? var.customer_managed_key : []
    content {
      key_vault_key_id          = customer_managed_key.value.key_vault_key_id
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
    }
  }

   dynamic "identity" {
    for_each = var.identity != null ? var.identity : []
    content {
      type                = identity.value.managed_identity_type
      identity_ids        = identity.value.managed_identity_type == "UserAssigned" || identity.value.managed_identity_type == "SystemAssigned, UserAssigned" ? identity.value.managed_identity_id : null
    }
  }

   dynamic "static_website" {
    for_each = (var.account_kind == "StorageV2" || var.account_kind == "BlockBlobStorage") && var.enable_static_website == true ? [var.enable_static_website] : []
    content {
      index_document               = static_website.value.static_website_index_document
      error_404_document           = static_website.value.static_website_error_doc
    }
  }

  #--------------------------------------------------------------------------------------------------------------------
  dynamic "share_properties" {
    for_each = var.enable_share_properties ? [1] : []
    content {

      dynamic "cors_rule" {
        for_each = var.cors_rule != null ? var.cors_rule : []
        content {
            allowed_headers             = cors_rule.value.shared_properties_allowed_headers
            allowed_methods             = cors_rule.value.shared_properties_allowed_methods
            allowed_origins             = cors_rule.value.shared_properties_allowed_origins
            exposed_headers             = cors_rule.value.shared_properties_exposed_headers
            max_age_in_seconds          = cors_rule.value.shared_properties_max_age_in_sec
         }
      }

      dynamic "retention_policy" {
        for_each = var.retention_policy != null ? var.retention_policy : []
        content {
          days = retention_policy.value.retention_policy_days
        }
      }

      dynamic "smb" {
        for_each = var.smb != null ? var.smb : []
        content {
          versions                        = smb.value.smb_versions
          authentication_types            = smb.value.smb_authentication_types
          kerberos_ticket_encryption_type = smb.value.smb_kerberos_ticket_encryption_type
          channel_encryption_type         = smb.value.channel_encryption_type
          multichannel_enabled            = smb.value.multichannel_enabled
        }
      }
    }
  }

  dynamic "azure_files_authentication" {
    for_each = var.azure_files_authentication != null ? var.azure_files_authentication : []
    content {
      directory_type = azure_files_authentication.value.directory_type

      dynamic "active_directory" {
        for_each = azure_files_authentication.value.directory_type == "AD" ? var.active_directory : []
        content {
          storage_sid         = active_directory.value.storage_sid
          domain_name         = active_directory.value.domain_name
          domain_sid          = active_directory.value.domain_sid
          domain_guid         = active_directory.value.domain_guid
          forest_name         = active_directory.value.forest_name
          netbios_domain_name = active_directory.value.netbios_domain_name
        }
      }
    }
  }

  dynamic "routing" {
    for_each = var.enable_routing ? var.routing : []
    content {
      publish_internet_endpoints             = routing.value.publish_internet_endpoints
      publish_microsoft_endpoints            = routing.value.publish_microsoft_endpoints
      choice                                 = routing.value.routing_choice
    }
  }

  dynamic "blob_properties" {
    for_each = var.enable_blob_properties ? var.blob_properties : []
    content {
      versioning_enabled            = blob_properties.value.enable_versioning
      last_access_time_enabled      = blob_properties.value.last_access_time_enabled
      change_feed_enabled           = blob_properties.value.change_feed_enabled
      change_feed_retention_in_days = blob_properties.value.change_feed_retention_in_days
      default_service_version       = blob_properties.value.default_service_version

      dynamic "cors_rule" {
        for_each = var.cors_rule_blob != null ? var.cors_rule_blob : []
        content {
          allowed_headers    = cors_rule_blob.value.blob_properties_allowed_headers
          allowed_methods    = cors_rule_blob.value.blob_properties_allowed_methods
          allowed_origins    = cors_rule_blob.value.blob_properties_allowed_origins
          exposed_headers    = cors_rule_blob.value.blob_properties_exposed_headers
          max_age_in_seconds = cors_rule_blob.value.blob_properties_max_age_in_sec
        }
      }

      dynamic "delete_retention_policy" {
        for_each = var.delete_retention_policy != null ? var.delete_retention_policy : []
        content {
          days = delete_retention_policy.value.blob_soft_delete_retention_days
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = var.container_delete_retention_policy != null ? var.container_delete_retention_policy : []
        content {
          days = container_delete_retention_policy.value.container_soft_delete_retention_days
        }
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.account_kind != "BlobStorage" ? var.queue_properties : []
    content {
      
      dynamic "cors_rule" {
        for_each = var.cors_rule_queue != null ? var.cors_rule_queue : []
        content {
          allowed_headers    = cors_rule_queue.value.queue_properties_allowed_headers
          allowed_methods    = cors_rule_queue.value.queue_properties_allowed_methods
          allowed_origins    = cors_rule_queue.value.queue_properties_allowed_origins
          exposed_headers    = cors_rule_queue.value.queue_properties_exposed_headers
          max_age_in_seconds = cors_rule_queue.value.queue_properties_max_age_in_sec
        }
      }

      dynamic "logging" {
        for_each = var.logging != null ? var.logging : []
        content {
          delete                = logging.value.logging_delete
          read                  = logging.value.logging_read
          version               = logging.value.logging_version
          write                 = logging.value.logging_write
          retention_policy_days = logging.value.logging_retention_policy_days
        }
      }

      dynamic "minute_metrics" {
        for_each = var.minute_metrics != null ? var.minute_metrics : []
        content {
          enabled               = minute_metrics.value.minute_metrics_enabled
          version               = minute_metrics.value.minute_metrics_version
          include_apis          = minute_metrics.value.minute_metrics_include_apis
          retention_policy_days = minute_metrics.value.minute_metrics_retention_policy_days
        }
      }

      dynamic "hour_metrics" {
        for_each = var.hour_metrics != null ? var.hour_metrics : []
        content {
          enabled               = hour_metrics.value.hour_metrics_enabled
          version               = hour_metrics.value.hour_metrics_version
          include_apis          = hour_metrics.value.hour_metrics_include_apis
          retention_policy_days = hour_metrics.value.hour_metrics_retention_policy_days
        }
      }
    }
  }
}

#------------------------------------------ Storage Account Network Rules ------------------------------------------------#

resource "azurerm_storage_account_network_rules" "storacc_nr" {
  for_each = toset(var.network_rules_enabled && !var.nfsv3_enabled ? ["enabled"] : [])
  storage_account_id         = azurerm_storage_account.sa.id
  default_action             = var.network_rule_default_action
  ip_rules                   = var.ip_rules
  virtual_network_subnet_ids = var.subnet_ids
  bypass                     = var.bypass
   dynamic "private_link_access" {
    for_each = var.private_link_access == null ? var.private_link_access : []
    content {
      endpoint_resource_id = private_link_access.value.endpoint_resource_id
      endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
    }
  }
}

#-------------------------------------------Storage encryption scope-------------------------------------------------------#

resource "azurerm_storage_encryption_scope" "scope" {
  #for_each                           = var.encryption_scopes != null ? var.encryption_scopes : []
  for_each                           = var.encryption_scopes
  name                               = each.key
  storage_account_id                 = azurerm_storage_account.sa.id
  source                             = each.value.source_encryption
  infrastructure_encryption_required = each.value.enable_infrastructure_encryption
}

#----------------------------------------- Advanced Threat Protection -----------------------------------------------------#

resource "azurerm_advanced_threat_protection" "atp" {
  target_resource_id = azurerm_storage_account.sa.id
  enabled            = var.enable_advanced_threat_protection
}

