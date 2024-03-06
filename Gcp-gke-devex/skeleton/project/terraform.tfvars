# With node pool config and private endpoint enabled
container_cluster_name   = "${{ values.container_cluster_name }}"
location                 = "${{ values.location }}"
project                  = "int-devops-cloud-0224"
#node_locations           = ["us-central1-a", "us-central1-b", "us-central1-c"]
#deletion_protection      = false
#network                  = "projects/int-devops-cloud-0224/global/networks/devex-vpc"
network                  = "devex-vpc"
#subnetwork               = "projects/int-devops-cloud-0224/regions/us-central1/subnetworks/gke-subnet1"
subnetwork                = "gke-subnet1"
#allow_net_admin          = true
#monitoring_service       = "monitoring.googleapis.com/kubernetes"
#cluster_ipv4_cidr        = "10.96.0.0/14"
#cluster_ipv4_cidr        = null
enable_autopilot         = true
#binary_authorization = {
#  evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
#}
#service_external_ips_config_enabled = true
#vertical_pod_autoscaling_enabled    = true
description                         = "${{ values.description }}"
#default_max_pods_per_node           = 8
#enable_kubernetes_alpha             = false
#gateway_api_config_channel          = "CHANNEL_STANDARD"
#release_channel                     = "STABLE"
#addons_config = {
#  horizontal_pod_autoscaling_disabled     = true
#  http_load_balancing_disabled            = true
#  gcs_fuse_csi_driver_config_enabled      = true
#  cloudrun_config = {
#    disabled           = true
#    load_balancer_type = "LOAD_BALANCER_TYPE_INTERNAL"
#  }
  #istio_config = {
  #  disabled = true
  #  auth     = "AUTH_MUTUAL_TLS"
 # }
 # dns_cache_config_enabled                      = true
 # gke_backup_agent_config_enabled               = true
 # kalm_config_enabled                           = true
 # config_connector_config_enabled               = true
#}
#maintenance_policy = {
#  recurring_window = {
#    start_time = "2019-01-01T00:00:00Z"
#    end_time   = "2019-01-02T00:00:00Z"
#    recurrence = "FREQ=DAILY"
#  }
#  maintenance_exclusion = {
#    exclusion_name = "batch job"
#    start_time     = "2019-01-01T00:00:00Z"
#    end_time       = "2019-01-02T00:00:00Z"
#    exclusion_options = {
#      scope = "NO_UPGRADES"
#    }
#  }
#}
#workload_identity_config_pool = "int-devops-cloud-0224.svc.id.goog"
#node_pool_autoscaling = {
#  min_node_count       = 0
#  total_min_node_count = 0
#  total_max_node_count = 5
#  location_policy      = "BALANCED"
#}
node_pool_name = "my-node-pool"
#node_pool_management = {
#  auto_repair  = true
#  auto_upgrade = true
#}
#node_pool_node_config = {
#  disk_size_gb                = 100
#  disk_type                   = "pd-standard"
#  enable_confidential_storage = true
#  ephemeral_storage_config = {
#    local_ssd_count = 0
#  }
#  ephemeral_storage_local_ssd_config = {
#    local_ssd_count = 0
#  }
#  fast_socket_enabled = true
#  local_nvme_ssd_block_config = {
#    local_ssd_count = 0
#  }
#  logging_variant     = "DEFAULT"
#  gcfs_config_enabled = true
#  gvnic_enabled       = true
#  guest_accelerator = {
#    count = 0
#    type  = "nvidia-tesla-k80"
#    gpu_driver_installation_config = {
#      gpu_driver_version = "DEFAULT"
#    }
#    gpu_partition_size = 1
#    gpu_sharing_config = {
#      gpu_sharing_strategy       = "MIG"
#      max_shared_clients_per_gpu = 1
#    }
#  }
#  image_type = "COS_CONTAINERD"
#  labels = {
#    "env" = "dev"
#  }
#  resource_labels = {
#    "resource" = "compute"
#  }
#  local_ssd_count = 0
#  machine_type    = "e2-medium"
#  metadata = {
#    "google-compute-enable-pvscsi" = "true"
#  }
  # conflicts with Node-group
  #   min_cpu_platform = "Intel Haswell"
#  oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
#  preemptible  = false
#  reservation_affinity = {
#    consume_reservation_type = "ANY_RESERVATION"
    #conflicts with consume_reservation_type
    # key = "compute.googleapis.com/reservation-name"
    # values = ["my-reservation"]
#  }
#  spot                = false
#  sandbox_config_type = "gvisor"
  #boot_disk_kms_key   = "projects/my-project/locations/global/keyRings/my-keyring/cryptoKeys/my-key"
#  service_account     = "gke-sa@int-devops-cloud-0224.iam.gserviceaccount.com"
#  shielded_instance_config = {
#    enable_secure_boot          = true
#    enable_integrity_monitoring = true
#  }
#  tags = ["web", "dev"]
#  taint = [
#    {
#      key    = "key1"
#      value  = "value1"
#      effect = "NO_SCHEDULE"
#    }
#  ]
#  workload_metadata_config_mode = "GCE_METADATA"
#  kubelet_config = {
#    cpu_manager_policy   = "static"
#    cpu_cfs_quota        = true
#    cpu_cfs_quota_period = "200ms"
#  }
#  linux_node_config_sysctls = {
#    "net.core.somaxconn" = "1024"
#  }
  #node_group = "my-node-group"
  #sole_tenant_config = {
  #  node_affinity = [
  #    {
  #      key      = "cloud.google.com/gke-nodepool"
  #      operator = "IN"
  #      values   = ["my-nodepool"]
  #    }
  #  ]
  #}
 # advanced_machine_features = {
 #   threads_per_core = 2
 # }
#}
private_cluster_config = {
  enable_private_nodes                = true
  enable_private_endpoint             = true
  master_ipv4_cidr_block              = "192.169.12.0/28"
  master_global_access_config_enabled = true
}
master_authorized_networks_config  = {
  cidr_blocks = [{
    cidr_block   = "10.0.12.0/28"
    display_name = "Bation Range"
  }]
  gcp_public_cidrs_access_enabled = false
}
ip_allocation_policy = {
  cluster_secondary_range_name  = "gke-pod"
  services_secondary_range_name = "gke-service"
}
