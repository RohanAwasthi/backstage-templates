resource_group_name      = "rg99"
location                 = "East US"
length                   = 6
special                  = false
upper                    = false
name                     = "str231m-test01"
account_tier             = "Premium"
account_replication_type = "LRS"
min_tls_version          = "TLS1_2"
tags = {
  project_id = "cil2.0"
  owner      = "gowtham.vidavaluru@gds.ey.com"
}
account_kind                     = "BlockBlobStorage"
cross_tenant_replication_enabled = "true"
access_tier                      = "Hot"
enable_https_traffic_only        = false
allow_nested_items_to_be_public  = true
shared_access_key_enabled        = true
is_hns_enabled                   = true
nfsv3_enabled                    = false
large_file_share_enabled         = false
enable_share_properties          = false
enable_routing                   = true
enable_blob_properties           = false
encryption_scopes = {
  "encrypt" = {
    enable_infrastructure_encryption = true
    source_encryption                = "Microsoft.Storage"

  }
}


