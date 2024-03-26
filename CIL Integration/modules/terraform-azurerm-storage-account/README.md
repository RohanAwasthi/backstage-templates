<!-- BEGIN_TF_DOCS -->

## Introduction

This module helps us to provision storage account along with the following resources:

* Storage Account Network Rules
* Storage Encryption Scope
* Advanced Threat Protection

* Note : We can integrate the service endpoint using "Microsoft.Storage".

## Requirements
| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\terraform) | 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.87.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_advanced_threat_protection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |
| [azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [azurerm_storage_encryption_scope](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_encryption_scope) | resource |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | It defines the access tier for the storage account i.e., Hot,Cool | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the kind of Storage Account possible values are: BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2 | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Storage account replication type - i.e. LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS. | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account (Standard or Premium). | `string` | n/a | yes |
| <a name="input_active_directory"></a> [active\_directory](#input\_active\_directory) | (Optional) storage\_sid            - Specifies the security identifier (SID) for Azure Storage<br>    (Required) domain\_name            - Specifies the primary domain that the AD DNS server is authoritative for<br>    (Optional) domain\_sid             - Specifies the security identifier (SID)<br>    (Required) domain\_guid            - Specifies the domain GUID<br>    (Optional) forest\_name            - Specifies the Active Directory forest<br>    (Optional) netbios\_domain\_name    - Specifies the NetBIOS domain name | <pre>list(object({<br>    storage_sid                 = string<br>    domain_name                 = string<br>    domain_sid                  = string<br>    domain_guid                 = string<br>    forest_name                 = string<br>    netbios_domain_name         = string<br>  }))</pre> | `[]` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Allow or disallow nested items within this Account to opt into being public | `bool` | `true` | no |
| <a name="input_azure_files_authentication"></a> [azure\_files\_authentication](#input\_azure\_files\_authentication) | (Optional) directory\_type    - Specifies the directory service used. Possible values are AADDS and AD | <pre>list(object({<br>    directory_type                    = string<br>  }))</pre> | `[]` | no |
| <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties) | (Optional) enable\_versioning              - to enable versioning<br>    (Optional) last\_access\_time\_enabled       - to enable last access time based tracking<br>    (Optional) change\_feed\_enabled            - to enable blob service properties for change feed events<br>    (Optional) change\_feed\_retention\_in\_days  - The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years).<br>    (Optional) default\_service\_version        - service version | <pre>list(object({<br>    enable_versioning                 = bool<br>    last_access_time_enabled          = bool<br>    change_feed_enabled               = bool<br>    change_feed_retention_in_days     = number<br>    default_service_version           = string<br>  }))</pre> | `[]` | no |
| <a name="input_bypass"></a> [bypass](#input\_bypass) | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None | `list(string)` | <pre>[<br>  "AzureServices"<br>]</pre> | no |
| <a name="input_container_delete_retention_policy"></a> [container\_delete\_retention\_policy](#input\_container\_delete\_retention\_policy) | (Optional) container\_soft\_delete\_retention\_days - Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7` | <pre>list(object({<br>    container_soft_delete_retention_days                 = number<br>  }))</pre> | `[]` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | (Required) shared\_properties\_allowed\_headers    - list of headers that are allowed to be a part of the cross-origin request<br>    (Required) shared\_properties\_allowed\_methods    - list of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.<br>    (Required) shared\_properties\_allowed\_origins    - list of origin domains that will be allowed by CORS<br>    (Required) shared\_properties\_exposed\_headers    - list of response headers that are exposed to CORS clients<br>    (Required) shared\_properties\_max\_age\_in\_sec     - number of seconds the client should cache a preflight response | <pre>list(object({<br>    shared_properties_allowed_headers                = list(string)<br>    shared_properties_allowed_methods                = list(string)<br>    shared_properties_allowed_origins                = list(string)<br>    shared_properties_exposed_headers                = list(string)<br>    shared_properties_max_age_in_sec                 = number<br>  }))</pre> | `[]` | no |
| <a name="input_cors_rule_blob"></a> [cors\_rule\_blob](#input\_cors\_rule\_blob) | (Required) blob\_properties\_allowed\_headers    - list of headers that are allowed to be a part of the cross-origin request<br>    (Required) blob\_properties\_allowed\_methods    - list of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.<br>    (Required) blob\_properties\_allowed\_origins    - list of origin domains that will be allowed by CORS<br>    (Required) blob\_properties\_exposed\_headers    - list of response headers that are exposed to CORS clients<br>    (Required) blob\_properties\_max\_age\_in\_sec     - number of seconds the client should cache a preflight response | <pre>list(object({<br>    blob_properties_allowed_headers                = list(string)<br>    blob_properties_allowed_methods                = list(string)<br>    blob_properties_allowed_origins                = list(string)<br>    blob_properties_exposed_headers                = list(string)<br>    blob_properties_max_age_in_sec                 = number<br>  }))</pre> | `[]` | no |
| <a name="input_cors_rule_queue"></a> [cors\_rule\_queue](#input\_cors\_rule\_queue) | (Required) queue\_properties\_allowed\_headers    - list of headers that are allowed to be a part of the cross-origin request<br>    (Required) queue\_properties\_allowed\_methods    - Tlist of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.<br>    (Required) queue\_properties\_allowed\_origins    - list of origin domains that will be allowed by CORS<br>    (Required) queue\_properties\_exposed\_headers    - list of response headers that are exposed to CORS clients<br>    (Required) queue\_properties\_max\_age\_in\_sec     - number of seconds the client should cache a preflight response | <pre>list(object({<br>    queue_properties_allowed_headers                = list(string)<br>    queue_properties_allowed_methods                = list(string)<br>    queue_properties_allowed_origins                = list(string)<br>    queue_properties_exposed_headers                = list(string)<br>    queue_properties_max_age_in_sec                 = number<br>  }))</pre> | `[]` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | For enabling cross Tenant replication | `bool` | `true` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | (Required) name             - The Custom Domain Name to use for the Storage Account<br>    (Optional) use\_subdomain    - Should the Custom Domain Name be validated by using indirect CNAME validation? | <pre>list(object({<br>    custom_domain_name     = string<br>    use_subdomain          = string<br>  }))</pre> | `[]` | no |
| <a name="input_custom_network_interface_name"></a> [custom\_network\_interface\_name](#input\_custom\_network\_interface\_name) | The custom name of the network interface attached to the private endpoint. | `string` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | (Required) key\_vault\_key\_id             - The ID of the Key Vault Key<br>    (Required) user\_assigned\_identity\_id    - The ID of a user assigned identity | <pre>list(object({<br>    key_vault_key_id                 = string<br>    user_assigned_identity_id        = string<br>  }))</pre> | `[]` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | to enable hierarchical namespace | `bool` | `false` | no |
| <a name="input_delete_retention_policy"></a> [delete\_retention\_policy](#input\_delete\_retention\_policy) | (Optional) blob\_soft\_delete\_retention\_days - Retention days for deleted blob. Valid value is between 1 and 365 (set to 0 to disable). | <pre>list(object({<br>    blob_soft_delete_retention_days                 = number<br>  }))</pre> | `[]` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | Specifies the Edge Zone within the Azure Region where this Storage Account should exist | `string` | `null` | no |
| <a name="input_enable_advanced_threat_protection"></a> [enable\_advanced\_threat\_protection](#input\_enable\_advanced\_threat\_protection) | to enable threat protection | `bool` | n/a | yes |
| <a name="input_enable_blob_properties"></a> [enable\_blob\_properties](#input\_enable\_blob\_properties) | to enable blob properties | `bool` | n/a | yes |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only) | Enabling this will force HTTPS traffic only | `bool` | `true` | no |
| <a name="input_enable_routing"></a> [enable\_routing](#input\_enable\_routing) | to enable routing | `bool` | n/a | yes |
| <a name="input_enable_share_properties"></a> [enable\_share\_properties](#input\_enable\_share\_properties) | To enable share properties block | `bool` | n/a | yes |
| <a name="input_enable_static_website"></a> [enable\_static\_website](#input\_enable\_static\_website) | to enable static website | `bool` | `null` | no |
| <a name="input_encryption_scopes"></a> [encryption\_scopes](#input\_encryption\_scopes) | Encryption scopes, keys are scope names. more info https://docs.microsoft.com/en-us/azure/storage/common/infrastructure-encryption-enable?tabs=portal | <pre>map(object({<br>    enable_infrastructure_encryption = bool<br>    source_encryption                = string<br>  }))</pre> | `{}` | no |
| <a name="input_hour_metrics"></a> [hour\_metrics](#input\_hour\_metrics) | (Required) hour\_metrics\_enabled                  - list of headers that are allowed to be a part of the cross-origin request<br>    (Required) hour\_metrics\_version                  - list of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.<br>    (Optional) hour\_metrics\_include\_apis             - list of origin domains that will be allowed by CORS<br>    (Optional) hour\_metrics\_retention\_policy\_days    - list of response headers that are exposed to CORS clients | <pre>list(object({<br>    hour_metrics_enabled                = bool<br>    hour_metrics_version                = string<br>    hour_metrics_include_apis           = bool<br>    hour_metrics_retention_policy_days  = number<br>  }))</pre> | `[]` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Required) managed\_identity\_type  - type of identity.<br>    (Required) managed\_identity\_id    - id of managed identity | <pre>list(object({<br>    managed_identity_type                 = string<br>    managed_identity_id                   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false. | `bool` | `false` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | (Required) name - Specifies the Name of the IP Configuration. Changing this forces a new resource to be created.<br>    (Required) private\_ip\_address - Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created.<br>    (Optional) subresource\_name - Specifies the subresource this IP address applies to. subresource\_names corresponds to group\_id. Changing this forces a new resource to be created.<br>    (Optional) member\_name - Specifies the member name this IP address applies to. If it is not specified, it will use the value of subresource\_name. Changing this forces a new resource to be created. | <pre>list(object({<br>    name                 = string<br>    private_ip_address   = string<br>    subresource_name     = optional(string)<br>    member_name          = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | List of public IP or IP ranges in CIDR Format. | `list(string)` | `null` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | to enable hierarchical namespace | `bool` | `false` | no |
| <a name="input_large_file_share_enabled"></a> [large\_file\_share\_enabled](#input\_large\_file\_share\_enabled) | to enable large file share | `bool` | `false` | no |
| <a name="input_length"></a> [length](#input\_length) | length of string | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Resource group location | `string` | n/a | yes |
| <a name="input_logging"></a> [logging](#input\_logging) | (Required) logging\_delete                    - Indicates whether all delete requests should be logged<br>    (Required) logging\_read                      - Indicates whether all read requests should be logged<br>    (Required) logging\_version                   - The version of storage analytics to configure<br>    (Required) logging\_write                     - Indicates whether all write requests should be logged<br>    (Optional) logging\_retention\_policy\_days     - Specifies the number of days that logs will be retained | <pre>list(object({<br>    logging_delete                                = bool<br>    logging_read                                  = bool<br>    logging_version                               = string<br>    logging_write                                 = bool<br>    logging_retention_policy_days                 = number<br>  }))</pre> | `[]` | no |
| <a name="input_managed_identity_type"></a> [managed\_identity\_type](#input\_managed\_identity\_type) | type of identity | `string` | `null` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the storage account. | `string` | `"TLS1_2"` | no |
| <a name="input_minute_metrics"></a> [minute\_metrics](#input\_minute\_metrics) | (Required) minute\_metrics\_enabled                  - list of headers that are allowed to be a part of the cross-origin request<br>    (Required) minute\_metrics\_version                  - list of HTTP methods that are allowed to be executed by the origin. Options are: DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.<br>    (Optional) minute\_metrics\_include\_apis             - list of origin domains that will be allowed by CORS<br>    (Optional) minute\_metrics\_retention\_policy\_days    - list of response headers that are exposed to CORS clients | <pre>list(object({<br>    minute_metrics_enabled                = bool<br>    minute_metrics_version                = string<br>    minute_metrics_include_apis           = bool<br>    minute_metrics_retention_policy_days  = number<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Storage account name | `string` | n/a | yes |
| <a name="input_network_rule_default_action"></a> [network\_rule\_default\_action](#input\_network\_rule\_default\_action) | Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow | `string` | `"Deny"` | no |
| <a name="input_network_rules_enabled"></a> [network\_rules\_enabled](#input\_network\_rules\_enabled) | Boolean to enable Network Rules on the Storage Account, requires `network_bypass`, `allowed_cidrs`, `subnet_ids` or `default_firewall_action` correctly set if enabled. | `bool` | `true` | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled) | to enable NFSv3 protocol | `bool` | `false` | no |
| <a name="input_private_dns_zone_group"></a> [private\_dns\_zone\_group](#input\_private\_dns\_zone\_group) | (Required) name - Specifies the Name of the Private DNS Zone Group.<br>    (Required) private\_dns\_zone\_ids - Specifies the list of Private DNS Zones to include within the private\_dns\_zone\_group. | <pre>list(object({<br>    name                 = string<br>    private_dns_zone_ids = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_private_link_access"></a> [private\_link\_access](#input\_private\_link\_access) | (Required) endpoint\_resource\_id  - The resource id of the resource access rule to be granted access<br>    (Optional) endpoint\_tenant\_id    - The tenant id of the resource of the resource access rule to be granted access | <pre>list(object({<br>    endpoint_resource_id        = string<br>    endpoint_tenant_id          = string<br>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | to enable hierarchical namespace | `bool` | `true` | no |
| <a name="input_queue_encryption_key_type"></a> [queue\_encryption\_key\_type](#input\_queue\_encryption\_key\_type) | The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service | `string` | `"Service"` | no |
| <a name="input_queue_properties"></a> [queue\_properties](#input\_queue\_properties) |  | <pre>list(object({<br> <br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | (Optional) retention\_policy\_days - Specifies the number of days that the azurerm\_storage\_share should be retained, between 1 and 365 days. | <pre>list(object({<br>    retention_policy_days                 = number<br>  }))</pre> | `[]` | no |
| <a name="input_routing"></a> [routing](#input\_routing) | (Optional) publish\_internet\_endpoints     - to publish internet routing storage endpoints<br>    (Optional) publish\_microsoft\_endpoints    - to publish Microsoft routing storage endpoints<br>    (Optional) routing\_choice                 - Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting | <pre>list(object({<br>    publish_internet_endpoints                 = bool<br>    publish_microsoft_endpoints                = bool<br>    routing_choice                             = string<br>  }))</pre> | `[]` | no |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | enable shared access key | `bool` | `true` | no |
| <a name="input_smb"></a> [smb](#input\_smb) | (Optional) smb\_versions                           - A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1<br>    (Optional) smb\_authentication\_types               - A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos<br>    (Optional) smb\_kerberos\_ticket\_encryption\_type    - A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256<br>    (Optional) channel\_encryption\_type                - A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM<br>    (Optional) multichannel\_enabled                   - Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts. | <pre>list(object({<br>    smb_versions                            = string<br>    smb_authentication_types                = string<br>    smb_kerberos_ticket_encryption_type     = string<br>    channel_encryption_type                 = string<br>    multichannel_enabled                    = bool<br>  }))</pre> | `[]` | no |
| <a name="input_special"></a> [special](#input\_special) | special character | `any` | n/a | yes |
| <a name="input_static_website"></a> [static\_website](#input\_static\_website) | (Optional) static\_website\_index\_document - The webpage that Azure Storage serves for requests to the root of a website or any subfolder<br>    (Optional) static\_website\_error\_doc      - webpage path to an non exixting file | <pre>list(object({<br>    static_website_index_document                 = string<br>    static_website_error_doc                      = string<br>  }))</pre> | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | list of subnet IDs | `list(string)` | `null` | no |
| <a name="input_table_encryption_key_type"></a> [table\_encryption\_key\_type](#input\_table\_encryption\_key\_type) | The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created | `string` | `"Service"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to be applied to resources | `map(string)` | n/a | yes |
| <a name="input_upper"></a> [upper](#input\_upper) | uppercase alphabet character | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_id"></a> [storage\_id](#output\_storage\_id) | The name of the resource group in which resources are created |
| <a name="output_storage_primary_access_key"></a> [storage\_primary\_access\_key](#output\_storage\_primary\_access\_key) | The primary access key for the storage account. |
| <a name="output_storage_primary_blob_connection_string"></a> [storage\_primary\_blob\_connection\_string](#output\_storage\_primary\_blob\_connection\_string) | The connection string associated with the primary blob location. |
| <a name="output_storage_primary_blob_endpoint"></a> [storage\_primary\_blob\_endpoint](#output\_storage\_primary\_blob\_endpoint) | The endpoint URL for blob storage in the primary location. |
| <a name="output_storage_primary_blob_host"></a> [storage\_primary\_blob\_host](#output\_storage\_primary\_blob\_host) | The hostname with port if applicable for blob storage in the primary location. |
| <a name="output_storage_primary_connection_string"></a> [storage\_primary\_connection\_string](#output\_storage\_primary\_connection\_string) | The connection string associated with the primary location. |
| <a name="output_storage_primary_dfs_endpoint"></a> [storage\_primary\_dfs\_endpoint](#output\_storage\_primary\_dfs\_endpoint) | The endpoint URL for DFS storage in the primary location. |
| <a name="output_storage_primary_dfs_host"></a> [storage\_primary\_dfs\_host](#output\_storage\_primary\_dfs\_host) | The hostname with port if applicable for DFS storage in the primary location. |
| <a name="output_storage_primary_file_endpoint"></a> [storage\_primary\_file\_endpoint](#output\_storage\_primary\_file\_endpoint) | The endpoint URL for file storage in the primary location. |
| <a name="output_storage_primary_file_host"></a> [storage\_primary\_file\_host](#output\_storage\_primary\_file\_host) | The hostname with port if applicable for file storage in the primary location. |
| <a name="output_storage_primary_location"></a> [storage\_primary\_location](#output\_storage\_primary\_location) | The primary location of the storage account. |
| <a name="output_storage_primary_queue_endpoint"></a> [storage\_primary\_queue\_endpoint](#output\_storage\_primary\_queue\_endpoint) | The endpoint URL for queue storage in the primary location. |
| <a name="output_storage_primary_queue_host"></a> [storage\_primary\_queue\_host](#output\_storage\_primary\_queue\_host) | The hostname with port if applicable for queue storage in the primary location. |
| <a name="output_storage_primary_table_endpoint"></a> [storage\_primary\_table\_endpoint](#output\_storage\_primary\_table\_endpoint) | The endpoint URL for table storage in the primary location. |
| <a name="output_storage_primary_table_host"></a> [storage\_primary\_table\_host](#output\_storage\_primary\_table\_host) | The hostname with port if applicable for table storage in the primary location. |
| <a name="output_storage_primary_web_endpoint"></a> [storage\_primary\_web\_endpoint](#output\_storage\_primary\_web\_endpoint) | The endpoint URL for web storage in the primary location. |
| <a name="output_storage_primary_web_host"></a> [storage\_primary\_web\_host](#output\_storage\_primary\_web\_host) | The hostname with port if applicable for web storage in the primary location. |
| <a name="output_storage_secondary_access_key"></a> [storage\_secondary\_access\_key](#output\_storage\_secondary\_access\_key) | The secondary access key for the storage account. |
| <a name="output_storage_secondary_blob_connection_string"></a> [storage\_secondary\_blob\_connection\_string](#output\_storage\_secondary\_blob\_connection\_string) | The connection string associated with the secondary blob location. |
| <a name="output_storage_secondary_blob_endpoint"></a> [storage\_secondary\_blob\_endpoint](#output\_storage\_secondary\_blob\_endpoint) | The endpoint URL for blob storage in the secondary location. |
| <a name="output_storage_secondary_blob_host"></a> [storage\_secondary\_blob\_host](#output\_storage\_secondary\_blob\_host) | The hostname with port if applicable for blob storage in the secondary location |
| <a name="output_storage_secondary_connection_string"></a> [storage\_secondary\_connection\_string](#output\_storage\_secondary\_connection\_string) | The connection string associated with the secondary location |
| <a name="output_storage_secondary_dfs_endpoint"></a> [storage\_secondary\_dfs\_endpoint](#output\_storage\_secondary\_dfs\_endpoint) | The endpoint URL for DFS storage in the secondary location. |
| <a name="output_storage_secondary_dfs_host"></a> [storage\_secondary\_dfs\_host](#output\_storage\_secondary\_dfs\_host) | The hostname with port if applicable for DFS storage in the secondary location. |
| <a name="output_storage_secondary_file_endpoint"></a> [storage\_secondary\_file\_endpoint](#output\_storage\_secondary\_file\_endpoint) | The endpoint URL for file storage in the secondary location. |
| <a name="output_storage_secondary_file_host"></a> [storage\_secondary\_file\_host](#output\_storage\_secondary\_file\_host) | The hostname with port if applicable for file storage in the secondary location. |
| <a name="output_storage_secondary_location"></a> [storage\_secondary\_location](#output\_storage\_secondary\_location) | The secondary location of the storage account. |
| <a name="output_storage_secondary_queue_endpoint"></a> [storage\_secondary\_queue\_endpoint](#output\_storage\_secondary\_queue\_endpoint) | The endpoint URL for queue storage in the secondary location. |
| <a name="output_storage_secondary_queue_host"></a> [storage\_secondary\_queue\_host](#output\_storage\_secondary\_queue\_host) | The hostname with port if applicable for queue storage in the secondary location. |
| <a name="output_storage_secondary_table_endpoint"></a> [storage\_secondary\_table\_endpoint](#output\_storage\_secondary\_table\_endpoint) | The endpoint URL for table storage in the secondary location. |
| <a name="output_storage_secondary_table_host"></a> [storage\_secondary\_table\_host](#output\_storage\_secondary\_table\_host) | The hostname with port if applicable for table storage in the secondary location. |
| <a name="output_storage_secondary_web_endpoint"></a> [storage\_secondary\_web\_endpoint](#output\_storage\_secondary\_web\_endpoint) | The endpoint URL for web storage in the secondary location |
| <a name="output_storage_secondary_web_host"></a> [storage\_secondary\_web\_host](#output\_storage\_secondary\_web\_host) | The hostname with port if applicable for web storage in the secondary location. |

## Module Usage 

~~~
module "storageacc" {

  source = "../../../modules/terraform-azurerm-storage-account"
  location                         = module.resource_group.location
  resource_group_name              = module.resource_group.name
  length                           = var.length
  special                          = var.special
  upper                            = var.upper
  name                             = var.name
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  min_tls_version                  = var.min_tls_version
  tags                             = var.tags
  account_kind                     = var.account_kind
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  access_tier                      = var.access_tier
  public_network_access_enabled    = var.public_network_access_enabled
  default_to_oauth_authentication  = var.default_to_oauth_authentication
  edge_zone                        = var.edge_zone
  enable_https_traffic_only        = var.enable_https_traffic_only
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  shared_access_key_enabled        = var.shared_access_key_enabled
  is_hns_enabled                   = var.is_hns_enabled
  nfsv3_enabled                    = var.nfsv3_enabled
  large_file_share_enabled         = var.large_file_share_enabled
  custom_domain                    = var.custom_domain
  customer_managed_key             = var.customer_managed_key
  identity                         = var.identity
  managed_identity_type            = var.managed_identity_type
  enable_static_website            = var.enable_static_website
  enable_share_properties          = var.enable_share_properties
  cors_rule                        = var.cors_rule
  retention_policy                 = var.retention_policy
  smb                              = var.smb
  azure_files_authentication       = var.azure_files_authentication
  active_directory                 = var.active_directory
  enable_routing                   = var.enable_routing
  routing                          = var.routing
  blob_properties                  = var.blob_properties
  cors_rule_blob                   = var.cors_rule_blob
  enable_blob_properties           = var.enable_blob_properties
  delete_retention_policy          = var.delete_retention_policy
  container_delete_retention_policy = var.container_delete_retention_policy
  queue_properties                 = var.queue_properties
  cors_rule_queue                  = var.cors_rule_queue
  logging                          = var.logging
  minute_metrics                   = var.minute_metrics
  hour_metrics                     = var.hour_metrics
  network_rule_default_action      = var.network_rule_default_action
  ip_rules                         = var.ip_rules
  subnet_ids                       = var.subnet_ids
  bypass                           = var.bypass
  private_link_access              = var.private_link_access
  network_rules_enabled            = var.network_rules_enabled
  encryption_scopes                = var.encryption_scopes
  enable_advanced_threat_protection = var.enable_advanced_threat_protection
  queue_encryption_key_type        = var.queue_encryption_key_type
  table_encryption_key_type        = var.table_encryption_key_type
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
  count  = var.create_private-endpoint ? 1 : 0
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
~~~
<!-- END_TF_DOCS -->