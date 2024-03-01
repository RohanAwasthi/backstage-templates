resource "google_container_cluster" "primary" {
  provider            = google-beta
  name                = var.container_cluster_name
  location            = var.location
  node_locations      = var.node_locations
  deletion_protection = var.deletion_protection
  dynamic "addons_config" {
    for_each = var.addons_config != null ? [var.addons_config] : []
    content {
      dynamic "horizontal_pod_autoscaling" {
        for_each = addons_config.value.horizontal_pod_autoscaling_disabled != null ? [1] : []
        content {
          disabled = addons_config.value.horizontal_pod_autoscaling_disabled
        }
      }
      dynamic "http_load_balancing" {
        for_each = addons_config.value.http_load_balancing_disabled != null ? [1] : []
        content {
          disabled = addons_config.value.http_load_balancing_disabled
        }
      }
      dynamic "network_policy_config" {
        for_each = addons_config.value.network_policy_config_disabled != null && var.enable_autopilot == false ? [1] : []
        content {
          disabled = addons_config.value.network_policy_config_disabled
        }
      }
      dynamic "gcp_filestore_csi_driver_config" {
        for_each = addons_config.value.gcp_filestore_csi_driver_config_enabled != null && var.enable_autopilot == false ? [1] : []
        content {
          enabled = addons_config.value.gcp_filestore_csi_driver_config_enabled
        }
      }
      dynamic "gcs_fuse_csi_driver_config" {
        for_each = addons_config.value.gcs_fuse_csi_driver_config_enabled != null ? [1] : []
        content {
          enabled = addons_config.value.gcs_fuse_csi_driver_config_enabled
        }
      }
      dynamic "cloudrun_config" {
        for_each = addons_config.value.cloudrun_config != null ? [addons_config.value.cloudrun_config] : []
        content {
          disabled           = cloudrun_config.value.disabled
          load_balancer_type = cloudrun_config.value.load_balancer_type
        }
      }
      dynamic "istio_config" {
        for_each = addons_config.value.istio_config != null ? [addons_config.value.istio_config] : []
        content {
          disabled = istio_config.value.disabled
          auth     = istio_config.value.auth
        }
      }
      dynamic "dns_cache_config" {
        for_each = addons_config.value.dns_cache_config_enabled != null ? [1] : []
        content {
          enabled = addons_config.value.dns_cache_config_enabled
        }
      }
      dynamic "gce_persistent_disk_csi_driver_config" {
        for_each = addons_config.value.gce_persistent_disk_csi_driver_config_enabled != null ? [1] : []
        content {
          enabled = addons_config.value.gce_persistent_disk_csi_driver_config_enabled
        }
      }
      dynamic "gke_backup_agent_config" {
        for_each = addons_config.value.gke_backup_agent_config_enabled != null ? [1] : []
        content {
          enabled = addons_config.value.gke_backup_agent_config_enabled
        }
      }
      dynamic "kalm_config" {
        for_each = addons_config.value.kalm_config_enabled != null ? [1] : []
        content {
          enabled = addons_config.value.kalm_config_enabled
        }
      }
      dynamic "config_connector_config" {
        for_each = addons_config.value.config_connector_config_enabled != null ? [1] : []
        content {
          enabled = addons_config.value.config_connector_config_enabled
        }
      }
    }
  }
  allow_net_admin   = var.enable_autopilot == true ? false : var.allow_net_admin
  cluster_ipv4_cidr = var.cluster_ipv4_cidr
  dynamic "cluster_autoscaling" {
    for_each = var.cluster_autoscaling != null ? [var.cluster_autoscaling] : []
    content {
      enabled = cluster_autoscaling.value.enabled
      dynamic "resource_limits" {
        for_each = cluster_autoscaling.value.resource_limits != null ? cluster_autoscaling.value.resource_limits : []
        content {
          resource_type = resource_limits.value.resource_type
          minimum       = resource_limits.value.minimum
          maximum       = resource_limits.value.maximum
        }
      }
      dynamic "auto_provisioning_defaults" {
        for_each = cluster_autoscaling.value.auto_provisioning_defaults != null ? [cluster_autoscaling.value.auto_provisioning_defaults] : []
        content {
          min_cpu_platform  = auto_provisioning_defaults.value.min_cpu_platform
          oauth_scopes      = auto_provisioning_defaults.value.oauth_scopes
          service_account   = auto_provisioning_defaults.value.service_account
          boot_disk_kms_key = auto_provisioning_defaults.value.boot_disk_kms_key
          disk_size         = auto_provisioning_defaults.value.disk_size_gb
          disk_type         = auto_provisioning_defaults.value.disk_type
          image_type        = auto_provisioning_defaults.value.image_type
          dynamic "shielded_instance_config" {
            for_each = auto_provisioning_defaults.value.shielded_instance_config != null ? [auto_provisioning_defaults.value.shielded_instance_config] : []
            content {
              enable_integrity_monitoring = shielded_instance_config.value.enable_integrity_monitoring
              enable_secure_boot          = shielded_instance_config.value.enable_secure_boot
            }
          }
          dynamic "management" {
            for_each = auto_provisioning_defaults.value.management != null ? [auto_provisioning_defaults.value.management] : []
            content {
              auto_repair  = management.value.auto_repair
              auto_upgrade = management.value.auto_upgrade
            }
          }
        }
      }
      autoscaling_profile = cluster_autoscaling.value.autoscaling_profile
    }
  }
  dynamic "binary_authorization" {
    for_each = var.binary_authorization != null ? [var.binary_authorization] : []
    content {
      #  enabled = binary_authorization.value.enabled - Deprecated in favor of evaluation_mode.
      evaluation_mode = binary_authorization.value.evaluation_mode
    }
  }
  dynamic "service_external_ips_config" {
    for_each = var.service_external_ips_config_enabled != null ? [1] : []
    content {
      enabled = var.service_external_ips_config_enabled
    }
  }
  dynamic "mesh_certificates" {
    for_each = var.mesh_certificates_enable != null ? [1] : []
    content {
      enable_certificates = var.mesh_certificates_enable
    }
  }
  dynamic "database_encryption" {
    for_each = var.database_encryption != null ? [var.database_encryption] : []
    content {
      state    = database_encryption.value.state
      key_name = database_encryption.value.key_name
    }
  }
  description               = var.description
  default_max_pods_per_node = var.enable_autopilot == "false" ? var.default_max_pods_per_node : null
  enable_kubernetes_alpha   = var.enable_kubernetes_alpha
  dynamic "enable_k8s_beta_apis" {
    for_each = var.enable_k8s_beta_api != null ? [1] : []
    content {
      enabled_apis = var.enable_k8s_beta_api
    }
  }
  enable_tpu            = var.enable_tpu
  enable_legacy_abac    = var.enable_legacy_abac
  enable_shielded_nodes = var.enable_shielded_nodes
  # Throws error if uncommented
  # enable_autopilot   = var.cluster_autoscaling == null ? var.enable_autopilot : null
  initial_node_count = var.initial_node_count
  dynamic "ip_allocation_policy" {
    for_each = var.ip_allocation_policy != null ? [var.ip_allocation_policy] : []
    content {
      cluster_secondary_range_name  = ip_allocation_policy.value.cluster_secondary_range_name
      services_secondary_range_name = ip_allocation_policy.value.services_secondary_range_name
      cluster_ipv4_cidr_block       = ip_allocation_policy.value.cluster_ipv4_cidr_block
      services_ipv4_cidr_block      = ip_allocation_policy.value.services_ipv4_cidr_block
      stack_type                    = ip_allocation_policy.value.stack_type
      dynamic "additional_pod_ranges_config" {
        for_each = ip_allocation_policy.value.additional_pod_range_names != null ? [1] : []
        content {
          pod_range_names = ip_allocation_policy.value.additional_pod_range_names
        }
      }
    }
  }
  networking_mode = var.networking_mode
  dynamic "logging_config" {
    for_each = var.logging_config_enable_components != null ? [1] : []
    content {
      enable_components = var.logging_config_enable_components
    }
  }
  logging_service = var.monitoring_service == null ? var.logging_service : null
  dynamic "maintenance_policy" {
    for_each = var.maintenance_policy != null ? [var.maintenance_policy] : []
    content {
      dynamic "daily_maintenance_window" {
        for_each = maintenance_policy.value.daily_maintenance_window != null ? [maintenance_policy.value.daily_maintenance_window] : []
        content {
          start_time = daily_maintenance_window.value.start_time
          duration   = daily_maintenance_window.value.duration
        }
      }
      dynamic "recurring_window" {
        for_each = maintenance_policy.value.recurring_window != null ? [maintenance_policy.value.recurring_window] : []
        content {
          start_time = recurring_window.value.start_time
          end_time   = recurring_window.value.end_time
          recurrence = recurring_window.value.recurrence
        }
      }
      # Throws error if uncommented
      # dynamic "maintenance_exclusion" {
      #   for_each = maintenance_policy.value.maintenance_exclusions != null ? [maintenance_policy.value.maintenance_exclusions] : []
      #   content {
      #     exclusion_name = maintenance_exclusions.value.exclusion_name
      #     start_time = maintenance_exclusions.value.start_time
      #     end_time = maintenance_exclusions.value.end_time
      #     dynamic "exclusion_options" {
      #       for_each = maintenance_exclusions.value.exclusion_options_scope != null ? [1] : []
      #       content {
      #         scope = maintenance_exclusions.value.exclusion_options_scope
      #       }
      #     }
      #   }
      # }
    }
  }
  dynamic "master_auth" {
    for_each = var.master_auth != null ? [var.master_auth] : []
    content {
      client_certificate_config {
        issue_client_certificate = master_auth.value.issue_client_certificate
      }
    }
  }
  dynamic "master_authorized_networks_config" {
    for_each = var.master_authorized_networks_config != null ? [var.master_authorized_networks_config] : []
    content {
      dynamic "cidr_blocks" {
        for_each = master_authorized_networks_config.value.cidr_blocks != null ? master_authorized_networks_config.value.cidr_blocks : []
        content {
          cidr_block   = cidr_blocks.value.cidr_block
          display_name = cidr_blocks.value.display_name
        }
      }
      gcp_public_cidrs_access_enabled = master_authorized_networks_config.value.gcp_public_cidrs_access_enabled
    }
  }
  min_master_version = var.min_master_version
  monitoring_service = var.logging_service == null ? var.monitoring_service : null
  dynamic "monitoring_config" {
    for_each = var.monitoring_config != null ? [1] : []
    content {
      enable_components = monitoring_config.value.enable_components
      dynamic "managed_prometheus" {
        for_each = monitoring_config.value.managed_prometheus_enabled != null ? [1] : []
        content {
          enabled = monitoring_config.value.managed_prometheus_enabled
        }
      }
      dynamic "advanced_datapath_observability_config" {
        for_each = monitoring_config.value.advanced_datapath_observability_config != null ? [monitoring_config.value.advanced_datapath_observability_config] : []
        content {
          enable_metrics = advanced_datapath_observability_config.value.enable_metrics
          relay_mode     = advanced_datapath_observability_config.value.relay_mode
        }
      }
    }
  }
  network = var.network
  dynamic "network_policy" {
    for_each = var.network_policy != null ? [var.network_policy] : []
    content {
      enabled  = network_policy.value.enabled
      provider = network_policy.value.provider
    }
  }
  dynamic "node_config" {
    for_each = var.node_config != null ? [var.node_config] : []
    content {
      disk_size_gb                = node_config.value.disk_size_gb
      disk_type                   = node_config.value.disk_type
      enable_confidential_storage = node_config.value.enable_confidential_storage
      dynamic "ephemeral_storage_config" {
        for_each = node_config.value.ephemeral_storage_config != null ? [node_config.value.ephemeral_storage_config] : []
        content {
          local_ssd_count = ephemeral_storage_config.value.local_ssd_count
        }
      }
      dynamic "ephemeral_storage_local_ssd_config" {
        for_each = node_config.value.ephemeral_storage_local_ssd_config != null ? [node_config.value.ephemeral_storage_local_ssd_config] : []
        content {
          local_ssd_count = ephemeral_storage_local_ssd_config.value.local_ssd_count
        }
      }
      dynamic "fast_socket" {
        for_each = node_config.value.fast_socket_enabled != null ? [1] : []
        content {
          enabled = node_config.value.fast_socket_enabled
        }
      }
      dynamic "local_nvme_ssd_block_config" {
        for_each = node_config.value.local_nvme_ssd_block_config != null ? [node_config.value.local_nvme_ssd_block_config] : []
        content {
          local_ssd_count = local_nvme_ssd_block_config.value.local_ssd_count
        }
      }
      logging_variant = node_config.value.logging_variant
      dynamic "gcfs_config" {
        for_each = node_config.value.gcfs_config_enabled != null ? [1] : []
        content {
          enabled = node_config.value.gcfs_config_enabled
        }
      }
      dynamic "gvnic" {
        for_each = node_config.value.gvnic_enabled != null ? [1] : []
        content {
          enabled = node_config.value.gvnic_enabled
        }
      }
      dynamic "guest_accelerator" {
        for_each = node_config.value.guest_accelerator != null ? [node_config.value.guest_accelerator] : []
        content {
          type  = guest_accelerator.value.type
          count = guest_accelerator.value.count
          dynamic "gpu_driver_installation_config" {
            for_each = guest_accelerator.value.gpu_driver_installation_config != null ? [guest_accelerator.value.gpu_driver_installation_config] : []
            content {
              gpu_driver_version = gpu_driver_installation_config.value.gpu_driver_version
            }
          }
          gpu_partition_size = guest_accelerator.value.gpu_partition_size
          dynamic "gpu_sharing_config" {
            for_each = guest_accelerator.value.gpu_sharing_config != null ? [guest_accelerator.value.gpu_sharing_config] : []
            content {
              gpu_sharing_strategy       = gpu_sharing_config.value.gpu_sharing_strategy
              max_shared_clients_per_gpu = gpu_sharing_config.value.max_shared_clients_per_gpu
            }
          }
        }
      }
      image_type       = node_config.value.image_type
      labels           = node_config.value.labels
      resource_labels  = node_config.value.resource_labels
      local_ssd_count  = node_config.value.local_ssd_count
      machine_type     = node_config.value.machine_type
      metadata         = node_config.value.metadata
      min_cpu_platform = node_config.value.min_cpu_platform
      oauth_scopes     = node_config.value.oauth_scopes
      preemptible      = node_config.value.preemptible
      dynamic "reservation_affinity" {
        for_each = node_config.value.reservation_affinity != null ? [node_config.value.reservation_affinity] : []
        content {
          consume_reservation_type = reservation_affinity.value.consume_reservation_type
          key                      = reservation_affinity.value.key
          values                   = reservation_affinity.value.values
        }
      }
      spot = node_config.value.spot
      dynamic "sandbox_config" {
        for_each = node_config.value.sandbox_config_type != null ? [1] : []
        content {
          sandbox_type = node_config.value.sandbox_config_type
        }
      }
      boot_disk_kms_key = node_config.value.boot_disk_kms_key
      service_account   = node_config.value.service_account
      dynamic "shielded_instance_config" {
        for_each = node_config.value.shielded_instance_config != null ? [node_config.value.shielded_instance_config] : []
        content {
          enable_integrity_monitoring = shielded_instance_config.value.enable_integrity_monitoring
          enable_secure_boot          = shielded_instance_config.value.enable_secure_boot
        }
      }
      tags = node_config.value.tags
      dynamic "taint" {
        for_each = node_config.value.taint != null ? [node_config.value.taint] : []
        content {
          key    = taint.value.key
          value  = taint.value.value
          effect = taint.value.effect
        }
      }
      dynamic "workload_metadata_config" {
        for_each = node_config.value.workload_metadata_config_mode != null ? [1] : []
        content {
          mode = node_config.value.workload_metadata_config_mode
        }
      }
      dynamic "kubelet_config" {
        for_each = node_config.value.kubelet_config != null ? [node_config.value.kubelet_config] : []
        content {
          cpu_manager_policy   = kubelet_config.value.cpu_manager_policy
          cpu_cfs_quota        = kubelet_config.value.cpu_cfs_quota
          cpu_cfs_quota_period = kubelet_config.value.cpu_cfs_quota_period
          pod_pids_limit       = kubelet_config.value.pod_pids_limit
        }
      }
      dynamic "linux_node_config" {
        for_each = node_config.value.linux_node_config_sysctls != null ? [1] : []
        content {
          sysctls     = node_config.value.linux_node_config_sysctls
          cgroup_mode = node_config.value.linux_node_config_cgroup_mode
        }
      }
      node_group = node_config.value.node_group
      dynamic "sole_tenant_config" {
        for_each = node_config.value.sole_tenant_config != null ? [node_config.value.sole_tenant_config] : []
        content {
          dynamic "node_affinity" {
            for_each = sole_tenant_config.value.node_affinity != null ? sole_tenant_config.value.node_affinity : []
            content {
              key      = node_affinity.value.key
              operator = node_affinity.value.operator
              values   = node_affinity.value.values
            }
          }
        }
      }
      dynamic "advanced_machine_features" {
        for_each = node_config.value.advanced_machine_features != null ? [node_config.value.advanced_machine_features] : []
        content {
          threads_per_core = advanced_machine_features.value.threads_per_core
        }
      }
    }
  }
  # node pool - 
  dynamic "node_pool_auto_config" {
    for_each = var.node_pool_auto_config != null ? [var.node_pool_auto_config] : []
    content {
      dynamic "network_tags" {
        for_each = node_pool_auto_config.value.network_tags != null ? [1] : []
        content {
          tags = node_pool_auto_config.value.network_tags
        }
      }
    }
  }

  dynamic "node_pool_defaults" {
    for_each = var.node_pool_defaults != null ? [var.node_pool_defaults] : []
    content {
      dynamic "node_config_defaults" {
        for_each = node_pool_defaults.value.node_config_defaults != null ? [node_pool_defaults.value.node_config_defaults] : []
        content {
          logging_variant = node_config_defaults.value.logging_variant
        }
      }
    }
  }
  node_version = var.node_version
  dynamic "notification_config" {
    for_each = var.notification_config != null ? [var.notification_config] : []
    content {
      pubsub {
        enabled = notification_config.value.pubsub_enabled
        topic   = notification_config.value.pubsub_topic
        dynamic "filter" {
          for_each = notification_config.value.filter_event_type != null ? [1] : []
          content {
            event_type = notification_config.value.filter_event_type
          }
        }
      }
    }
  }
  dynamic "confidential_nodes" {
    for_each = var.confidential_nodes_enabled != null ? [var.confidential_nodes_enabled] : []
    content {
      enabled = var.confidential_nodes_enabled
    }
  }
  dynamic "pod_security_policy_config" {
    for_each = var.pod_security_policy_config_enabled != null ? [1] : []
    content {
      enabled = var.pod_security_policy_config_enabled
    }
  }
  dynamic "authenticator_groups_config" {
    for_each = var.authenticator_groups_config_security_group != null ? [1] : []
    content {
      security_group = var.authenticator_groups_config_security_group
    }
  }
  dynamic "private_cluster_config" {
    for_each = var.private_cluster_config != null ? [var.private_cluster_config] : []
    content {
      enable_private_nodes    = private_cluster_config.value.enable_private_nodes
      enable_private_endpoint = private_cluster_config.value.enable_private_endpoint
      master_ipv4_cidr_block  = private_cluster_config.value.master_ipv4_cidr_block 
      dynamic "master_global_access_config" {
        for_each = private_cluster_config.value.master_global_access_config_enabled != null ? [1] : []
        content {
          enabled = private_cluster_config.value.master_global_access_config_enabled
        }
      }
    }
  }
  dynamic "cluster_telemetry" {
    for_each = var.cluster_telemetry_type != null ? [1] : []
    content {
      type = var.cluster_telemetry_type
    }
  }
  project = var.project
  dynamic "release_channel" {
    for_each = var.release_channel != null ? [1] : []
    content {
      channel = var.release_channel
    }
  }
  remove_default_node_pool = var.remove_default_node_pool
  resource_labels          = var.resource_labels
  dynamic "cost_management_config" {
    for_each = var.cost_management_config_enabled != null ? [1] : []
    content {
      enabled = var.cost_management_config_enabled
    }
  }
  dynamic "resource_usage_export_config" {
    for_each = var.resource_usage_export_config != null ? [var.resource_usage_export_config] : []
    content {
      enable_network_egress_metering       = resource_usage_export_config.value.enable_network_egress_metering
      enable_resource_consumption_metering = resource_usage_export_config.value.enable_resource_consumption_metering
      bigquery_destination {
        dataset_id = resource_usage_export_config.value.bigquery_destination_dataset_id
      }
    }
  }
  subnetwork = var.subnetwork
  dynamic "vertical_pod_autoscaling" {
    for_each = var.vertical_pod_autoscaling_enabled != null ? [1] : []
    content {
      enabled = var.vertical_pod_autoscaling_enabled
    }
  }
  dynamic "workload_identity_config" {
    for_each = var.workload_identity_config_pool != null ? [var.workload_identity_config_pool] : []
    content {
      workload_pool = var.workload_identity_config_pool
    }
  }
  dynamic "identity_service_config" {
    for_each = var.identity_service_config_enabled != null ? [1] : []
    content {
      enabled = var.identity_service_config_enabled
    }
  }
  enable_intranode_visibility = var.enable_intranode_visibility
  enable_l4_ilb_subsetting    = var.enable_l4_ilb_subsetting
  enable_multi_networking     = var.enable_multi_networking
  enable_fqdn_network_policy  = var.enable_fqdn_network_policy
  private_ipv6_google_access  = var.private_ipv6_google_access
  datapath_provider           = var.datapath_provider
  dynamic "default_snat_status" {
    for_each = var.default_snat_status_disabled != null ? [1] : []
    content {
      disabled = var.default_snat_status_disabled
    }
  }
  dynamic "dns_config" {
    for_each = var.dns_config != null ? [var.dns_config] : []
    content {
      cluster_dns        = dns_config.value.cluster_dns
      cluster_dns_scope  = dns_config.value.scope
      cluster_dns_domain = dns_config.value.cluster_dns_domain
    }
  }
  dynamic "gateway_api_config" {
    for_each = var.gateway_api_config_channel != null ? [1] : []
    content {
      channel = var.gateway_api_config_channel
    }
  }
  dynamic "protect_config" {
    for_each = var.protect_config != null ? [var.protect_config] : []
    content {
      workload_vulnerability_mode = protect_config.value.workload_vulnerability_mode
      # This block throws error if uncommented
      # dynamic "workload_config" {
      #   for_each = protect_config.value.workload_config_audit != null ? [1] : []
      #   content {
      #     audit_mode = protect_config.value.workload_config_audit
      #   }
      # }
    }
  }
  dynamic "security_posture_config" {
    for_each = var.security_posture_config != null ? [var.security_posture_config] : []
    content {
      mode               = security_posture_config.value.mode
      vulnerability_mode = security_posture_config.value.vulnerability_mode
    }
  }
  dynamic "fleet" {
    for_each = var.fleet_project != null ? [1] : []
    content {
      project = var.fleet_project
    }
  }
  dynamic "workload_alts_config" {
    for_each = var.workload_alts_config_enable != null ? [1] : []
    content {
      enable_alts = var.workload_alts_config_enable
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name     = var.node_pool_name
  cluster  = google_container_cluster.primary.id
  location = var.location
  node_count = var.node_pool_node_count
  dynamic "autoscaling" {
    for_each = var.node_pool_autoscaling != null ? [var.node_pool_autoscaling] : []
    content {
      min_node_count       = autoscaling.value.min_node_count
      max_node_count       = autoscaling.value.max_node_count
      total_max_node_count = autoscaling.value.total_max_node_count
      total_min_node_count = autoscaling.value.total_min_node_count
      location_policy      = autoscaling.value.location_policy
    }
  }
  initial_node_count = var.node_pool_initial_node_count
  dynamic "management" {
    for_each = var.node_pool_management != null ? [var.node_pool_management] : []
    content {
      auto_repair  = management.value.auto_repair
      auto_upgrade = management.value.auto_upgrade
    }
  }
  max_pods_per_node = var.node_pool_max_pods_per_node
  node_locations    = var.node_pool_node_locations
  name_prefix       = var.node_pool_name == null ? var.node_pool_name_prefix : null
  project           = var.project
  dynamic "node_config" {
    for_each = var.node_pool_node_config != null ? [var.node_pool_node_config] : []
    content {
      disk_size_gb = node_config.value.disk_size_gb
      disk_type    = node_config.value.disk_type
      dynamic "ephemeral_storage_local_ssd_config" {
        for_each = node_config.value.ephemeral_storage_local_ssd_config != null ? [node_config.value.ephemeral_storage_local_ssd_config] : []
        content {
          local_ssd_count = ephemeral_storage_local_ssd_config.value.local_ssd_count
        }
      }
      dynamic "fast_socket" {
        for_each = node_config.value.fast_socket_enabled != null ? [1] : []
        content {
          enabled = node_config.value.fast_socket_enabled
        }
      }
      dynamic "local_nvme_ssd_block_config" {
        for_each = node_config.value.local_nvme_ssd_block_config != null ? [node_config.value.local_nvme_ssd_block_config] : []
        content {
          local_ssd_count = local_nvme_ssd_block_config.value.local_ssd_count
        }
      }
      logging_variant = node_config.value.logging_variant
      dynamic "gcfs_config" {
        for_each = node_config.value.gcfs_config_enabled != null ? [1] : []
        content {
          enabled = node_config.value.gcfs_config_enabled
        }
      }
      dynamic "gvnic" {
        for_each = node_config.value.gvnic_enabled != null ? [1] : []
        content {
          enabled = node_config.value.gvnic_enabled
        }
      }
      dynamic "guest_accelerator" {
        for_each = node_config.value.guest_accelerator != null ? [node_config.value.guest_accelerator] : []
        content {
          type  = guest_accelerator.value.type
          count = guest_accelerator.value.count
          dynamic "gpu_driver_installation_config" {
            for_each = guest_accelerator.value.gpu_driver_installation_config != null ? [guest_accelerator.value.gpu_driver_installation_config] : []
            content {
              gpu_driver_version = gpu_driver_installation_config.value.gpu_driver_version
            }
          }
          gpu_partition_size = guest_accelerator.value.gpu_partition_size
          dynamic "gpu_sharing_config" {
            for_each = guest_accelerator.value.gpu_sharing_config != null ? [guest_accelerator.value.gpu_sharing_config] : []
            content {
              gpu_sharing_strategy       = gpu_sharing_config.value.gpu_sharing_strategy
              max_shared_clients_per_gpu = gpu_sharing_config.value.max_shared_clients_per_gpu
            }

          }
        }
      }
      image_type       = node_config.value.image_type
      labels           = node_config.value.labels
      resource_labels  = node_config.value.resource_labels
      local_ssd_count  = node_config.value.local_ssd_count
      machine_type     = node_config.value.machine_type
      metadata         = node_config.value.metadata
      min_cpu_platform = node_config.value.min_cpu_platform
      oauth_scopes     = node_config.value.oauth_scopes
      preemptible      = node_config.value.preemptible
      dynamic "reservation_affinity" {
        for_each = node_config.value.reservation_affinity != null ? [node_config.value.reservation_affinity] : []
        content {
          consume_reservation_type = reservation_affinity.value.consume_reservation_type
          key                      = reservation_affinity.value.key
          values                   = reservation_affinity.value.values
        }
      }
      spot              = node_config.value.spot
      boot_disk_kms_key = node_config.value.boot_disk_kms_key
      service_account   = node_config.value.service_account
      dynamic "shielded_instance_config" {
        for_each = node_config.value.shielded_instance_config != null ? [node_config.value.shielded_instance_config] : []
        content {
          enable_integrity_monitoring = shielded_instance_config.value.enable_integrity_monitoring
          enable_secure_boot          = shielded_instance_config.value.enable_secure_boot
        }
      }
      tags = node_config.value.tags
      dynamic "taint" {
        for_each = node_config.value.taint != null ? node_config.value.taint : []
        content {
          key    = taint.value.key
          value  = taint.value.value
          effect = taint.value.effect
        }
      }
      dynamic "workload_metadata_config" {
        for_each = node_config.value.workload_metadata_config_mode != null ? [1] : []
        content {
          mode = node_config.value.workload_metadata_config_mode
        }
      }
      dynamic "kubelet_config" {
        for_each = node_config.value.kubelet_config != null ? [node_config.value.kubelet_config] : []
        content {
          cpu_manager_policy   = kubelet_config.value.cpu_manager_policy
          cpu_cfs_quota        = kubelet_config.value.cpu_cfs_quota
          cpu_cfs_quota_period = kubelet_config.value.cpu_cfs_quota_period
          pod_pids_limit = kubelet_config.value.pod_pids_limit
        }
      }
      dynamic "linux_node_config" {
        for_each = node_config.value.linux_node_config_sysctls != null ? [1] : []
        content {
          sysctls = node_config.value.linux_node_config_sysctls
          # cgroup_mode = node_config.value.linux_node_config_cgroup_mode
        }
      }
      node_group = node_config.value.node_group
      dynamic "sole_tenant_config" {
        for_each = node_config.value.sole_tenant_config != null ? [node_config.value.sole_tenant_config] : []
        content {
          dynamic "node_affinity" {
            for_each = sole_tenant_config.value.node_affinity != null ? sole_tenant_config.value.node_affinity : []
            content {
              key      = node_affinity.value.key
              operator = node_affinity.value.operator
              values   = node_affinity.value.values
            }
          }
        }
      }
      dynamic "advanced_machine_features" {
        for_each = node_config.value.advanced_machine_features != null ? [node_config.value.advanced_machine_features] : []
        content {
          threads_per_core = advanced_machine_features.value.threads_per_core
        }
      }
    }
  }

  dynamic "network_config" {
    for_each = var.node_pool_network_config != null ? [var.node_pool_network_config] : []
    content {
      create_pod_range     = network_config.value.create_pod_range
      enable_private_nodes = network_config.value.enable_private_nodes
      pod_ipv4_cidr_block  = network_config.value.pod_ipv4_cidr_block
      pod_range            = network_config.value.pod_range
    }
  }
  dynamic "upgrade_settings" {
    for_each = var.node_pool_upgrade_settings != null ? [var.node_pool_upgrade_settings] : []
    content {
      max_surge       = upgrade_settings.value.max_surge
      max_unavailable = upgrade_settings.value.max_unavailable
      strategy        = upgrade_settings.value.strategy
      dynamic "blue_green_settings" {
        for_each = upgrade_settings.value.blue_green_settings != null ? [upgrade_settings.value.blue_green_settings] : []
        content {
          standard_rollout_policy {
            batch_percentage    = upgrade_settings.value.batch_percentage
            batch_node_count    = upgrade_settings.value.batch_node_count
            batch_soak_duration = upgrade_settings.value.batch_soak_duration
          }
          node_pool_soak_duration = upgrade_settings.value.node_pool_soak_duration
        }
      }
    }
  }
  version = var.node_pool_version
  dynamic "placement_policy" {
    for_each = var.node_pool_placement_policy != null ? [var.node_pool_placement_policy] : []
    content {
      type         = placement_policy.value.type
      # policy_name  = placement_policy.value.policy_name
      # tpu_topology = placement_policy.value.tpu_topology
    }
  }
  depends_on = [
    google_container_cluster.primary
  ]
}

