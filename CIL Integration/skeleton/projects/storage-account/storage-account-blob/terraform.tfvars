resource_group_name      = "rg99"
location                 = "East US"
length                   = 6
special                  = false
upper                    = false
name                     = "str231m-test01"
account_tier             = "Standard"
account_replication_type = "LRS"
min_tls_version          = "TLS1_2"
tags = {
  project_id = "cil2.0"
  owner      = "gowtham.vidavaluru@gds.ey.com"
}

account_kind                     = "BlobStorage"
cross_tenant_replication_enabled = "true"
access_tier                      = "Hot"
enable_https_traffic_only        = false
allow_nested_items_to_be_public  = true
shared_access_key_enabled        = true
is_hns_enabled                   = true
nfsv3_enabled                    = false
enable_blob_properties           = false
network_rule_default_action      = "Allow"
ip_rules                         = ["127.0.0.0"]
subnet_ids                       = ["/subscriptions/812aa5e4-bb0f-4352-9170-4d09ab8a5952/resourceGroups/rg99/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1"]
bypass                           = ["Metrics"]
encryption_scopes = {
  "encrypt" = {
    enable_infrastructure_encryption = true
    source_encryption                = "Microsoft.Storage"
  }
}

