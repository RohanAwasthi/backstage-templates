diagnostic_setting_name        = "diag-1-mg"
target_resource_id             = "/subscriptions/dcd2c118-9f88-4a53-8b1b-fbc235ad0bef/resourceGroups/cloudifyrgmit/providers/Microsoft.Sql/servers/cildatatestserver/databases/cil-test-01"
log_analytics_destination_type = "Dedicated"
logs_destinations_ids          = ["/subscriptions/dcd2c118-9f88-4a53-8b1b-fbc235ad0bef/resourceGroups/cloudifyrgmit/providers/Microsoft.Storage/storageAccounts/mgstg01"]
log_categories                 = ["SQLInsights", "QueryStoreWaitStatistics"]
metrics                        = ["WorkloadManagement"]
