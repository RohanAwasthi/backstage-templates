#-----------------------------------Resource Group--------------------------------------------------------------
variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}
variable "location" {
  description = "Resource group location"
  type        = string
}

#------------------------------------Random String-----------------------------------------------------------

variable "length" {
  description = "length of string"
  type        = string
}

variable "special" {
  description = "special character"
}

variable "upper" {
  description = "uppercase alphabet character"
  type = bool
  default = true
}

#------------------------------------- Storage Account ---------------------------------------------------
variable "name" {
  description = "Storage account name"
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account (Standard or Premium)."
  type        = string
}

variable "account_replication_type" {
  description = "Storage account replication type - i.e. LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  type        = string
  default     = "LRS"
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account."
  type        = string
  default     = "TLS1_2"
}

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
}

variable "account_kind" {
  description = "Defines the kind of Storage Account possible values are: BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
  type        = string
  default     = "StorageV2"
}

variable "cross_tenant_replication_enabled" {
  description = "For enabling cross Tenant replication"
  type        = bool
  default     = true
}

variable "access_tier" {
  description = "It defines the access tier for the storage account i.e., Hot,Cool"
  type        = string
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Storage Account should exist"
  type        = string
  default     = null
}

variable "enable_https_traffic_only" {
  description = "Enabling this will force HTTPS traffic only"
  type        = bool
  default     = true
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public"
  type        = bool
  default     = true
}

variable "shared_access_key_enabled" {
  description = "enable shared access key"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "to enable hierarchical namespace"
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "to enable hierarchical namespace"
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "to enable hierarchical namespace"
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  description = "to enable NFSv3 protocol"
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "to enable large file share"
  type        = bool
  default     = false
}

variable "queue_encryption_key_type" {
  description = "The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service"
  type        = string
  default     = "Service"
}

variable "table_encryption_key_type" {
  description = "The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created"
  type        = string
  default     = "Service"
}

variable "infrastructure_encryption_enabled" {
  description = "Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false."
  type        = bool
  default     = false
}
#---------------------------custom domain-------------------------

variable "custom_domain" {
  description = <<EOF
    (Required) name             - The Custom Domain Name to use for the Storage Account
    (Optional) use_subdomain    - Should the Custom Domain Name be validated by using indirect CNAME validation?
  EOF
  type = list(object({
    custom_domain_name = string
    use_subdomain      = string
  }))
  default = []
}
#------------------------customer managed key-------------------

variable "customer_managed_key" {
  description = <<EOF
    (Required) key_vault_key_id             - Whether rule processing is On (true) or Paused(false).
    (Required) user_assigned_identity_id    - The rule that determines membership of this group.
  EOF
  type = list(object({
    key_vault_key_id          = string
    user_assigned_identity_id = string
  }))
  default = []
}
#---------------------identity-----------------------------------
variable "managed_identity_type" {
  description = "type of identity"
  type        = string
  default     = null
}

variable "identity" {
  description = <<EOF
    (Required) managed_identity_type - type of identity.
    (Required) managed_identity_id    - id of managed identity
  EOF
  type = list(object({
    managed_identity_type = string
    managed_identity_id   = list(string)
  }))
  default = []
}

#--------------------------static website---------------------------
variable "enable_static_website" {
  description = "to enable static website"
  type        = bool
  default     = false
}

variable "static_website" {
  description = <<EOF
    (Optional) static_website_index_document - The webpage that Azure Storage serves for requests to the root of a website or any subfolder
    (Optional) static_website_error_doc      - webpage path to an non exixting file
  EOF
  type = list(object({
    static_website_index_document = string
    static_website_error_doc      = string
  }))
  default = []
}
#----------------------------share properties----------------------------
variable "enable_share_properties" {
  description = "To enable share properties block"
  type        = bool
  default     = false
}
############################ cors rule

variable "cors_rule" {
  description = <<EOF
    (Required) shared_properties_allowed_headers    - list of headers that are allowed to be a part of the cross-origin request
    (Required) shared_properties_allowed_methods    - Tlist of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
    (Required) shared_properties_allowed_origins    - list of origin domains that will be allowed by CORS
    (Required) shared_properties_exposed_headers    - list of response headers that are exposed to CORS clients
    (Required) shared_properties_max_age_in_sec     - number of seconds the client should cache a preflight response
  EOF
  type = list(object({
    shared_properties_allowed_headers = list(string)
    shared_properties_allowed_methods = list(string)
    shared_properties_allowed_origins = list(string)
    shared_properties_exposed_headers = list(string)
    shared_properties_max_age_in_sec  = number
  }))
  default = []
}
############################# retention policy

variable "retention_policy" {
  description = <<EOF
    (Optional) retention_policy_days - Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days.
  EOF
  type = list(object({
    retention_policy_days = number
  }))
  default = []
}
############################ smb

variable "smb" {
  description = <<EOF
    (Optional) smb_versions                           - A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1
    (Optional) smb_authentication_types               - A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos
    (Optional) smb_kerberos_ticket_encryption_type    - A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256
    (Optional) channel_encryption_type                - A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM
    (optional) multichannel_enabled                   - Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
  EOF
  type = list(object({
    smb_versions                        = string
    smb_authentication_types            = string
    smb_kerberos_ticket_encryption_type = string
    channel_encryption_type             = string
    multichannel_enabled                = bool
  }))
  default = []
}

#--------------------------------------Azure files authentication---------------------------
######################## active directory

variable "azure_files_authentication" {
  description = <<EOF
    (Optional) directory_type    - Specifies the directory service used. Possible values are AADDS and AD
  EOF
  type = list(object({
    directory_type = string
  }))
  default = []
}

variable "active_directory" {
  description = <<EOF
    (Optional) storage_sid           - Specifies the security identifier (SID) for Azure Storage
    (Required) domain_name           - Specifies the primary domain that the AD DNS server is authoritative for
    (Optional) domain_sid            - Specifies the security identifier (SID)
    (Required) domain_guid           - Specifies the domain GUID
    (Optional) forest_name           - Specifies the Active Directory forest
    (Optional) netbios_domain_name   - Specifies the NetBIOS domain name
  EOF
  type = list(object({
    storage_sid         = string
    domain_name         = string
    domain_sid          = string
    domain_guid         = string
    forest_name         = string
    netbios_domain_name = string
  }))
  default = []
}

#------------------------------------------------routing----------------------------------------
variable "enable_routing" {
  description = "to enable routing"
  type        = bool
  default     = true
}

variable "routing" {
  description = <<EOF
    (Optional) publish_internet_endpoints     - to publish internet routing storage endpoints
    (Optional) publish_microsoft_endpoints    - to publish Microsoft routing storage endpoints
    (Optional) routing_choice                 - Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting
  EOF
  type = list(object({
    publish_internet_endpoints  = bool
    publish_microsoft_endpoints = bool
    routing_choice              = string
  }))
  default = []
}
#--------------------------------------------blob_properties-------------------------------------
variable "enable_blob_properties" {
  description = "to enable blob properties"
  type        = bool
  default     = false
}

variable "blob_properties" {
  description = <<EOF
    (Optional) enable_versioning              - to enable versioning
    (Optional) last_access_time_enabled       - to enable last access time based tracking
    (Optional) change_feed_enabled            - to enable blob service properties for change feed events
    (Optional) change_feed_retention_in_days  - The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years).
    (Optional) default_service_version        - service version
  EOF
  type = list(object({
    enable_versioning             = bool
    last_access_time_enabled      = bool
    change_feed_enabled           = bool
    change_feed_retention_in_days = number
    default_service_version       = string
  }))
  default = []
}
################################### cors rule

variable "cors_rule_blob" {
  description = <<EOF
    (Required) blob_properties_allowed_headers    - list of headers that are allowed to be a part of the cross-origin request
    (Required) blob_properties_allowed_methods    - list of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
    (Required) blob_properties_allowed_origins    - list of origin domains that will be allowed by CORS
    (Required) blob_properties_exposed_headers    - list of response headers that are exposed to CORS clients
    (Required) blob_properties_max_age_in_sec     - number of seconds the client should cache a preflight response
  EOF
  type = list(object({
    blob_properties_allowed_headers = list(string)
    blob_properties_allowed_methods = list(string)
    blob_properties_allowed_origins = list(string)
    blob_properties_exposed_headers = list(string)
    blob_properties_max_age_in_sec  = number
  }))
  default = []
}
##################################### delete retention policy

variable "delete_retention_policy" {
  description = <<EOF
    (Optional) blob_soft_delete_retention_days - Retention days for deleted blob. Valid value is between 1 and 365 (set to 0 to disable).
  EOF
  type = list(object({
    blob_soft_delete_retention_days = number
  }))
  default = []
}
##################################### container delete retention policy

variable "container_delete_retention_policy" {
  description = <<EOF
    (Optional) container_soft_delete_retention_days - Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`
  EOF
  type = list(object({
    container_soft_delete_retention_days = number
  }))
  default = []
}
#----------------------------------------- queue properties --------------
variable "queue_properties" {
  description = <<EOF

  EOF
  type = list(object({

  }))
  default = []
}
##################################### cors rule

variable "cors_rule_queue" {
  description = <<EOF
    (Required) queue_properties_allowed_headers    - list of headers that are allowed to be a part of the cross-origin request
    (Required) queue_properties_allowed_methods    - list of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
    (Required) queue_properties_allowed_origins    - list of origin domains that will be allowed by CORS
    (Required) queue_properties_exposed_headers    - list of response headers that are exposed to CORS clients
    (Required) queue_properties_max_age_in_sec     - number of seconds the client should cache a preflight response
  EOF
  type = list(object({
    queue_properties_allowed_headers = list(string)
    queue_properties_allowed_methods = list(string)
    queue_properties_allowed_origins = list(string)
    queue_properties_exposed_headers = list(string)
    queue_properties_max_age_in_sec  = number
  }))
  default = []
}
################################### logging

variable "logging" {
  description = <<EOF
    (Required) logging_delete                    - Indicates whether all delete requests should be logged
    (Required) logging_read                      - Indicates whether all read requests should be logged
    (Required) logging_version                   - The version of storage analytics to configure
    (Required) logging_write                     - Indicates whether all write requests should be logged
    (Optional) logging_retention_policy_days     - Specifies the number of days that logs will be retained
  EOF
  type = list(object({
    logging_delete                = bool
    logging_read                  = bool
    logging_version               = string
    logging_write                 = bool
    logging_retention_policy_days = number
  }))
  default = []
}
################################ minute metrics
variable "minute_metrics" {
  description = <<EOF
    (Required) minute_metrics_enabled                  - list of headers that are allowed to be a part of the cross-origin request
    (Required) minute_metrics_version                  - Tlist of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
    (Optional) minute_metrics_include_apis             - list of origin domains that will be allowed by CORS
    (Optional) minute_metrics_retention_policy_days    - list of response headers that are exposed to CORS clients
  EOF
  type = list(object({
    minute_metrics_enabled               = bool
    minute_metrics_version               = string
    minute_metrics_include_apis          = bool
    minute_metrics_retention_policy_days = number
  }))
  default = []
}
################################# hour metrics
variable "hour_metrics" {
  description = <<EOF
    (Required) hour_metrics_enabled                  - list of headers that are allowed to be a part of the cross-origin request
    (Required) hour_metrics_version                  - list of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
    (Optional) hour_metrics_include_apis             - list of origin domains that will be allowed by CORS
    (Optional) hour_metrics_retention_policy_days    - list of response headers that are exposed to CORS clients
  EOF
  type = list(object({
    hour_metrics_enabled               = bool
    hour_metrics_version               = string
    hour_metrics_include_apis          = bool
    hour_metrics_retention_policy_days = number
  }))
  default = []
}
#--------------------------------------------------------- storage account network rules--------------------------------------
variable "network_rules_enabled" {
  description = "Boolean to enable Network Rules on the Storage Account, requires `network_bypass`, `allowed_cidrs`, `subnet_ids` or `default_firewall_action` correctly set if enabled."
  type        = bool
  default     = true
}

variable "network_rule_default_action" {
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow"
  type        = string
  default     = "Deny"
}
variable "ip_rules" {
  description = " List of public IP or IP ranges in CIDR Format."
  type        = list(string)
  default     = null
}
variable "subnet_ids" {
  description = "list of subnet IDs"
  type        = list(string)
  default     = null
}
variable "bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None"
  type        = list(string)
  default     = ["AzureServices"]
}
#################################### private link access

variable "private_link_access" {
  description = <<EOF
    (Required) endpoint_resource_id - The resource id of the resource access rule to be granted access
    (Optional) endpoint_tenant_id    - The tenant id of the resource of the resource access rule to be granted access
  EOF
  type = list(object({
    endpoint_resource_id = string
    endpoint_tenant_id   = string
  }))
  default = []
}
#------------------------------storage encryption scope---------
variable "encryption_scopes" {
  description = "Encryption scopes, keys are scope names. more info https://docs.microsoft.com/en-us/azure/storage/common/infrastructure-encryption-enable?tabs=portal"
  type = map(object({
    enable_infrastructure_encryption = bool
    source_encryption                = string
  }))

}
#-----------------------------------------------------------threat protection--------------------------------------------------
variable "enable_advanced_threat_protection" {
  description = "to enable threat protection"
  type        = bool
  default     = true
}
