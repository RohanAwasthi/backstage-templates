variable "container_cluster_name" {
  description = "The name of the cluster."
  type        = string
}

variable "location" {
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. "
  type        = string
  default     = "us-central1-a"
}

variable "node_locations" {
  description = "The list of zones in which the cluster's nodes are located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. If this is specified for a zonal cluster, omit the cluster's zone."
  type        = list(string)
  default     = null
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the cluster. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply that would delete the cluster will fail."
  type        = bool
  default     = false
}

variable "addons_config" {
  description = <<EOF
  The configuration of addons supported by GKE. Structure is documented below.
  horizontal_pod_autoscaling_disabled - (Optional) Configurations for the Horizontal Pod Autoscaling feature, which increases or decreases the number of replica pods a replication controller has based on the resource usage of the existing pods.
  http_load_balancing_disabled - (Optional) Configurations for the HTTP (L7) load balancing controller, which makes it easy to set up HTTP load balancers for services in a cluster.
  network_policy_config_disabled - (Optional) Configurations for the NetworkPolicy feature, which controls the traffic between pods.
  gcp_filestore_csi_driver_config_enabled - (Optional) Configurations for the GCP Filestore CSI Driver feature, which provides a way to use Filestore volumes in a Kubernetes cluster.
  gcs_fuse_csi_driver_config_enabled - (Optional) Configurations for the GCS FUSE CSI Driver feature, which provides a way to use GCS buckets in a Kubernetes cluster.
  cloudrun_config block supports:
    disabled - (Optional) Whether Cloud Run addon is enabled for the cluster.
    load_balancer_type - (Optional) The load balancer type to use for Cloud Run. Possible values are: "LOAD_BALANCER_TYPE_UNSPECIFIED", "LOAD_BALANCER_TYPE_EXTERNAL", "LOAD_BALANCER_TYPE_INTERNAL". Default value is "LOAD_BALANCER_TYPE_UNSPECIFIED".
  istio_config block supports:
    disabled - (Optional) Whether Istio is enabled for the cluster.
    auth - (Optional) The Istio auth mode for the cluster. Possible values are: "AUTH_NONE", "AUTH_MUTUAL_TLS". Default value is "AUTH_NONE".
  dns_cache_config_enabled - (Optional) Configurations for the DNS Cache feature, which improves the performance of DNS queries.
  gce_persistent_disk_csi_driver_config_enabled - (Optional) Configurations for the GCE Persistent Disk CSI Driver feature, which provides a way to use GCE Persistent Disks in a Kubernetes cluster.
  gke_backup_agent_config_enabled - (Optional) Configurations for the GKE Backup Agent feature, which provides a way to backup and restore GKE clusters.
  kalm_config_enabled - (Optional) Configurations for the Kalm feature, which provides a way to deploy and manage applications on Kubernetes.
  config_connector_config_enabled - (Optional) Configurations for the Config Connector feature, which provides a way to manage GCP resources using Kubernetes.    
  EOF  
  type = object({
    horizontal_pod_autoscaling_disabled     = optional(bool)
    http_load_balancing_disabled            = optional(bool)
    network_policy_config_disabled          = optional(bool)
    gcp_filestore_csi_driver_config_enabled = optional(bool)
    gcs_fuse_csi_driver_config_enabled      = optional(bool)
    cloudrun_config = optional(object({
      disabled           = optional(bool)
      load_balancer_type = optional(string)
    }))
    istio_config = optional(object({
      disabled = optional(bool)
      auth     = optional(string)
    }))
    dns_cache_config_enabled                      = optional(bool)
    gce_persistent_disk_csi_driver_config_enabled = optional(bool)
    gke_backup_agent_config_enabled               = optional(bool)
    kalm_config_enabled                           = optional(bool)
    config_connector_config_enabled               = optional(bool)
  })
  default = null
}

variable "allow_net_admin" {
  description = "Enable NET_ADMIN for the cluster. Defaults to false. This field should only be enabled for Autopilot clusters (enable_autopilot set to true)."
  type        = bool
  default     = false
}

variable "cluster_ipv4_cidr" {
  description = "The IP address range of the Kubernetes pods in this cluster in CIDR notation (e.g. 10.96.0.0/14). Leave blank to have one automatically chosen or specify a /14 block in 10.0.0.0/8. This field will default a new cluster to routes-based, where ip_allocation_policy is not defined."
  type        = string
  default     = null
}

variable "cluster_autoscaling" {
  description = <<EOF
  The autoscaling settings of the cluster. Structure is documented below.
  enabled - (Optional) Whether the Node Auto-Provisioning feature is enabled. When enabled, the NodePool's min_node_count and max_node_count will be honored.
  resource_limits block supports:
    resource_type - (Required) Resource type that the quantity applies to. Possible values are "cpu" and "memory".
    minimum - (Optional) Minimum amount of the resource in the cluster. If specified, the value must be at least 0.
    maximum - (Optional) Maximum amount of the resource in the cluster. If specified, the value must be at least 0.
  auto_provisioning_defaults block supports:
    min_cpu_platform - (Optional) Minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. Applicable values are the friendly names of CPU platforms, such as minCpuPlatform: "Intel Haswell" or minCpuPlatform: "Intel Sandy Bridge". For more information, read how to specify min CPU platform.
    oauth_scopes - (Optional) Scopes that are used by default. The following scopes are recommended, but not required, and by default are not included: https://www.googleapis.com
    service_account - (Optional) The Google Cloud Platform Service Account to be used by the node VMs. If no Service Account is specified, the "default" service account is used.
    boot_disk_kms_key - (Optional) The Customer Managed Encryption Key used to encrypt the boot disk attached to the node. The Customer Managed Encryption Key must be in the same region as the cluster. When specified, the node boot disk will be encrypted with the provided Customer Managed Encryption Key using Google Cloud Storage encryption. If unspecified, the boot disk will be encrypted with Google default encryption.
    disk_size_gb - (Optional) Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. If unspecified, the default disk size is 100GB.
    disk_type - (Optional) Type of the disk attached to each node (e.g. 'pd-standard', 'pd-ssd' or 'pd-balanced'). If unspecified, the default disk type is 'pd-standard'
    image_type - (Optional) The image type to use for this node. Note that for a given image type, the latest version of it will be used.
    shielded_instance_config block supports:
      enable_secure_boot - (Optional) Defines whether the instance has Secure Boot enabled. Secure Boot helps ensure that the system only runs authentic software by verifying the digital signature of all boot components, and halting the boot process if signature verification fails.
      enable_integrity_monitoring - (Optional) Defines whether the instance has integrity monitoring enabled. Enables monitoring and attestation of the boot integrity of the instance. The attestation is performed against the integrity policy baseline. This baseline is initially derived from the implicitly trusted boot image when the instance is created.
    management block supports:
      auto_repair - (Optional) A flag that specifies whether the node auto-repair is enabled for the node pool. If enabled, the nodes in this node pool will be monitored and, if they fail health checks too many times, an automatic repair action will be triggered.
      auto_upgrade - (Optional) A flag that specifies whether node auto-upgrade is enabled. This defaults to true. If enabled, node auto-upgrade helps keep the nodes in your node pool up to date with the latest release version of Kubernetes.
    autoscaling_profile - (Optional) The autoscaling profile of the NodePool. Possible values are "BALANCED" and "OPTIMIZE_UTILIZATION". Defaults to "BALANCED".      
  EOF
  type = object({
    enabled = optional(bool)
    resource_limits = optional(list(object({
      resource_type = string
      minimum       = optional(number)
      maximum       = optional(number)
    })))
    auto_provisioning_defaults = optional(object({
      min_cpu_platform  = optional(string)
      oauth_scopes      = optional(list(string))
      service_account   = optional(string)
      boot_disk_kms_key = optional(string)
      disk_size_gb      = optional(number, 100)
      disk_type         = optional(string, "pd-standard")
      image_type        = optional(string)
      shielded_instance_config = optional(object({
        enable_secure_boot          = optional(bool, false)
        enable_integrity_monitoring = optional(bool, true)
      }))
      management = optional(object({
        auto_repair  = optional(bool)
        auto_upgrade = optional(bool)
      }))
    }))
    autoscaling_profile = optional(string, "BALANCED")
  })
  default = null
}

variable "binary_authorization" {
  description = "Mode of operation for Binary Authorization policy evaluation. Valid values are DISABLED and PROJECT_SINGLETON_POLICY_ENFORCE."
  type = object({
    evaluation_mode = optional(string)
  })
  default = null
}

variable "service_external_ips_config_enabled" {
  description = "Controls whether external ips specified by a service will be allowed. It is enabled by default."
  type        = bool
  default     = null
}

variable "mesh_certificates_enable" {
  description = "Controls the issuance of workload mTLS certificates. It is enabled by default. Workload Identity is required, see workload_config."
  type        = bool
  default     = null
}

variable "database_encryption" {
  description = <<EOF
  The database encryption settings of the cluster. Structure is documented below.
  state - (Optional) The state of the database encryption. Possible values are "DECRYPTED" and "ENCRYPTED". Default value is "DECRYPTED".
  key_name - (Optional) The name of the encryption key to use. When creating a new cluster, this field is required. When updating an existing cluster, this field must be empty.
  EOF
  type = object({
    state    = string
    key_name = string
  })
  default = null
}

variable "description" {
  description = "The sample description of the cluster."
  type        = string
}

variable "default_max_pods_per_node" {
  description = "The default maximum number of pods per node in this cluster. This doesn't work on routes-based clusters, clusters that don't have IP Aliasing enabled. "
  type        = number
  default     = null
}

variable "enable_kubernetes_alpha" {
  description = "Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days."
  type        = bool
  default     = null
}

variable "enable_k8s_beta_api" {
  description = "Enabled Kubernetes Beta APIs. To list a Beta API resource, use the representation {group}/{version}/{resource}. The version must be a Beta version. Note that you cannot disable beta APIs that are already enabled on a cluster without recreating it."
  type        = list(any)
  default     = null
}

variable "enable_tpu" {
  description = "Whether to enable Cloud TPU resources in this cluster"
  type        = bool
  default     = null
}

variable "enable_legacy_abac" {
  description = "Whether the ABAC authorizer is enabled for this cluster. When enabled, identities in the system, including service accounts, nodes, and controllers, will have statically granted permissions beyond those provided by the RBAC configuration or IAM. Defaults to false"
  type        = bool
  default     = false
}

variable "enable_shielded_nodes" {
  description = "Enable Shielded Nodes features on all nodes in this cluster. Defaults to true."
  type        = bool
  default     = true
}

variable "enable_autopilot" {
  description = "Enable Autopilot for this cluster. Defaults to false. Note that when this option is enabled, certain features of Standard GKE are not available. "
  type        = bool
  default     = null
}

variable "initial_node_count" {
  description = "The number of nodes to create in this cluster's default node pool. In regional or multi-zonal clusters, this is the number of nodes per zone. Must be set if node_pool is not set. If you're using google_container_node_pool objects with no default node pool, you'll need to set this to a value of at least 1, alongside setting remove_default_node_pool to true."
  type        = number
  default     = 1
}

variable "ip_allocation_policy" {
  description = <<EOF
  Ip_allocation_policy block supports the following:
  cluster_secondary_range_name - (Optional) The name of the secondary range to be used as for the cluster CIDR block. The secondary range will be used for pod IP addresses. This must be an existing secondary range associated with the cluster subnetwork. This field is only applicable with use_ip_aliases is true and create_subnetwork is false.
  services_secondary_range_name - (Optional) The name of the secondary range to be used as for the services CIDR block. The secondary range will be used for service ClusterIPs. This must be an existing secondary range associated with the cluster subnetwork. This field is only applicable with use_ip_aliases is true and create_subnetwork is false.
  cluster_ipv4_cidr_block - (Optional) The IP address range for the cluster pod IPs. If this field is set, then cluster.cluster_ipv4_cidr must be left blank.
  services_ipv4_cidr_block - (Optional) The IP address range of the services IPs in this cluster. If blank, a range will be automatically chosen with the default size. If this field is set, then cluster.services_ipv4_cidr must be left blank.
  stack_type - (Optional) The type of IP allocation to be used in the cluster. This must be either 'IPV4' or 'IPV6'. If this field is unspecified, then the cluster's IP allocation policy will be left unchanged (IPV4).
  additional_pod_range_names - (Optional) The name of the secondary range to be used as for the cluster CIDR block. The secondary range will be used for pod IP addresses. This must be an existing secondary range associated with the cluster subnetwork. This field is only applicable with use_ip_aliases is true and create_subnetwork is false.
  EOF
  type = object({
    cluster_secondary_range_name  = optional(string)
    services_secondary_range_name = optional(string)
    cluster_ipv4_cidr_block       = optional(string)
    services_ipv4_cidr_block      = optional(string)
    stack_type                    = optional(string, "IPV4")
    additional_pod_range_names    = optional(list(string))
  })
  default = null
}

variable "networking_mode" {
  description = "Determines whether alias IPs or routes will be used for pod IPs in the cluster. Options are VPC_NATIVE or ROUTES. VPC_NATIVE enables IP aliasing. Newly created clusters will default to VPC_NATIVE."
  type        = string
  default     = "VPC_NATIVE"
  validation {
    condition     = contains(["VPC_NATIVE", "ROUTES"], var.networking_mode)
    error_message = "The possible values for networking_mode are VPC_NATIVE and ROUTES."

  }
}
variable "logging_config_enable_components" {
  description = "The GKE components exposing logs. Supported values include: SYSTEM_COMPONENTS, APISERVER, CONTROLLER_MANAGER, SCHEDULER, and WORKLOADS."
  type        = list(string)
  default     = []
}

variable "logging_service" {
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com(Legacy Stackdriver), logging.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Logging), and none. Defaults to logging.googleapis.com/kubernetes"
  type        = string
  validation {
    condition     = contains(["logging.googleapis.com", "logging.googleapis.com/kubernetes"], var.logging_service)
    error_message = "The possible values for logging.googleapis.com and logging.googleapis.com/kubernetes."
  }
  default = "logging.googleapis.com/kubernetes"
}

variable "maintenance_policy" {
  description = <<EOF
  Maintenance_policy block supports the following:
  daily_maintenance_window supports:
    start_time - (Optional) Time within the maintenance window to start the maintenance operations. It must be in format "HH:MM", where HH : [00-23] and MM : [00-59] GMT.
    duration - (Optional) Duration of the time window, automatically chosen to be smallest possible in the given scenario.
  recurring_window supports:
    start_time - (Optional) Time within the maintenance window to start the maintenance operations. It must be in format "HH:MM", where HH : [00-23] and MM : [00-59] GMT.
    end_time - (Optional) Time within the maintenance window to end the maintenance operations. It must be in format "HH:MM", where HH : [00-23] and MM : [00-59] GMT.
    recurrence - (Optional) An RRULE (https://tools.ietf.org/html/rfc5545#section-
  maintenance_exclusions supports:
    exclusion_name - (Optional) The name of the maintenance exclusion. It must be unique within the project.
    start_time - (Optional) Time within the maintenance window to start the maintenance operations. It must be in format "HH:MM", where HH : [00-23] and MM : [00-59] GMT.
    end_time - (Optional) Time within the maintenance window to end the maintenance operations. It must be in format "HH:MM", where HH : [00-23] and MM : [00-59] GMT.
    exclusion_options_scope - (Optional) The scope at which the maintenance exclusion applies. The possible values are "ZONE" and "CLUSTER". Default value is "ZONE".    
  EOF
  type = object({
    daily_maintenance_window = optional(object({
      start_time = optional(string)
      duration   = optional(string)
    }))
    recurring_window = optional(object({
      start_time = optional(string)
      end_time   = optional(string)
      recurrence = optional(string)
    }))
    maintenance_exclusions = optional(object({
      exclusion_name          = optional(string)
      start_time              = optional(string)
      end_time                = optional(string)
      exclusion_options_scope = optional(string)
    }))
  })
  default = null
}

variable "master_auth" {
  description = <<EOF
  Master_auth block supports the following:
    issue_client_certificate - (Optional) Whether client certificate is enabled for secure cluster communication. If enabled, issuance is handled by GKE. If disabled, a client certificate must be manually issued.
  EOF
  type = object({
    issue_client_certificate = bool
  })
  default = null
}

variable "master_authorized_networks_config" {
  description = <<EOF
    Cidr_blocks supports:
      cidr_block - (Required) The IP address range in CIDR notation to add to the master authorized network list.
      display_name - (Optional) An optional description of the block.
    gcp_public_cidrs_access_enabled - (Optional) Whether GCP public IP CIDRs will be allowed access to the master.  
    EOF
  type = object({
    cidr_blocks = optional(list(object({
      cidr_block   = optional(string)
      display_name = optional(string)
    })))
    gcp_public_cidrs_access_enabled = optional(bool)
  })
  default = null
}

variable "min_master_version" {
  description = "The current version of the master in the cluster. This may be different than the min_master_version set in the config if the master has been updated by GKE."
  type        = string
  default     = null
}

variable "monitoring_service" {
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com(Legacy Stackdriver), monitoring.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Monitoring), and none. Defaults to monitoring.googleapis.com/kubernetes"
  type        = string
  validation {
    condition     = contains(["monitoring.googleapis.com", "monitoring.googleapis.com/kubernetes"], var.monitoring_service)
    error_message = "The possible values for monitoring_service are monitoring.googleapis.com and monitoring.googleapis.com/kubernetes."
  }
  default = "monitoring.googleapis.com/kubernetes"
}

variable "monitoring_config" {
  description = <<EOF
  Monitoring_config block supports the following:
  enable_components - (Optional) The list of monitoring components to disable. This should be used to disable the default components of the cluster. The default is not to disable any components.
  managed_prometheus_enabled - (Optional) Whether to enable the managed Prometheus component. Default is false.
  advanced_datapath_observability_config supports:
    enable_metrics - (Required) Whether to enable the collection of network and system metrics.
    relay_mode - (Optional) The mode of the Datapath relay. Default is "DEFAULT". 
  EOF 
  type = object({
    enable_components          = optional(string)
    managed_prometheus_enabled = optional(bool)
    advanced_datapath_observability_config = optional(object({
      enable_metrics = bool
      relay_mode     = optional(string)
    }))
  })
  default = null
}

variable "network" {
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network."
  type        = string
  default     = null
}

variable "network_policy" {
  description = <<EOF
  Network_policy block supports the following:
  enabled - (Optional) Whether network policy is enabled on the cluster. Default is false.
  provider - (Optional) The selected network policy provider. Possible values are "CALICO" and "ACCELERATED". Default is "CALICO".
  EOF
  type = object({
    enabled  = bool
    provider = optional(string, "PROVIDER_UNSPECIFIED")
  })
  default = null
}

variable "node_config" {
  description = <<EOF
  Node_config block supports the following:
  disk_size_gb - (Optional) Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. If unspecified, the default disk size is 100GB.
  disk_type - (Optional) Type of the disk attached to each node (e.g. 'pd-standard', 'pd-ssd' or 'pd-balanced'). If unspecified, the default disk type is 'pd-standard'
  enable_confidential_storage - (Optional) Whether the nodes are created as confidential VMs.
  ephemeral_storage_config:
    local_ssd_count - (Optional) The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on the machine type of the node. The minimum value allowed is 0. If not specified, the default is 0.
  ephemeral_storage_local_ssd_config:
    local_ssd_count - (Optional) The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on the machine type of the node. The minimum value allowed is 0. If not specified, the default is 0.
  fast_socket_enabled - (Optional) Whether the node's runtime performance is optimized for high performance.
  local_nvme_ssd_block_config:
    local_ssd_count - (Optional) The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on the machine type of the node. The minimum value allowed is 0. If not specified, the default is 0.
  logging_variant - (Optional) The type of logging agent that is deployed by default for newly created node pools in the cluster. Valid values include DEFAULT and MAX_THROUGHPUT. See Increasing logging agent throughput for more information.
  gcfs_config_enabled - (Optional) Whether the GKE Filestore CSI Driver is enabled for the node pool.
  gvnic_enabled - (Optional) Whether the GvNIC feature is enabled for the node pool.
  guest_accelerator:
    count - (Optional) The number of the guest accelerator cards exposed to this instance.
    type - (Optional) The type of the guest accelerator cards exposed to this instance. The default is "nvidia-tesla-v100".
    gpu_driver_installation_config:
      gpu_driver_version - (Optional) The GPU driver version to install on the node. The default is the latest supported version.
    gpu_partition_size - (Optional) Size of the GPU partition. If not specified, the default is 0.
    gpu_sharing_config:
      gpu_sharing_strategy - (Optional) The GPU sharing strategy. Possible values are "NO_SHARING", "SINGLE_INSTANCE" and "MULTI_INSTANCE". The default is "NO_SHARING".
      max_shared_clients_per_gpu - (Optional) The maximum number of instances that can share a single physical GPU. The default is 0.
    image_type - (Optional) The image type to use for this node. Note that for a given image type, the latest version of it will be used.
    labels - (Optional) The map of labels to be attached to this node.
    resource_labels - (Optional) The map of resource labels to be attached to this node.
    local_ssd_count - (Optional) The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on the machine type of the node. The minimum value allowed is 0. If not specified, the default is 0.
    machine_type - (Optional) The name of a Google Compute Engine machine type. The default is "e2-medium".
    metadata - (Optional) The metadata key/value pairs assigned to instances in the cluster.
    min_cpu_platform - (Optional) The minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. Applicable values are the friendly names of CPU platforms, such as minCpuPlatform: "Intel Haswell" or minCpuPlatform: "Intel Sandy Bridge". For more information, read how to specify min CPU platform.
    oauth_scopes - (Optional) The set of Google API scopes to be made available on all of the node VMs under the "default" service account. The default is "https://www.googleapis.com/auth/cloud-platform".
    preemptible - (Optional) Whether the nodes are created as preemptible VM instances. The default is false.
    reservation_affinity:
      consume_reservation_type - (Optional) Corresponds to the type of reservation to consume. Possible values are "ANY_RESERVATION" and "SPECIFIC_RESERVATION". The default is "ANY_RESERVATION".
      key - (Optional) Corresponds to the label key of a reservation resource. The key must be empty if consume_reservation_type is "ANY_RESERVATION".
      values - (Optional) Corresponds to the label values of a reservation resource. The values must be 1:1 with key.
    spot - (Optional) Whether the nodes are created as preemptible VM instances. The default is false.
    sandbox_config_type - (Optional) The sandbox configuration for this node.
    boot_disk_kms_key - (Optional) The Customer Managed Encryption Key used to encrypt the boot disk attached to the node. The Customer Managed Encryption Key must be in the same region as the cluster. When specified, the node boot disk will be encrypted with the provided Customer Managed Encryption Key using Google Cloud Storage encryption. If unspecified, the boot disk will be encrypted with Google default encryption.
    service_account - (Optional) The Google Cloud Platform Service Account to be used by the node VMs. If no Service Account is specified, the "default" service account is used.
    shielded_instance_config:
      enable_secure_boot - (Optional) Defines whether the instance has Secure Boot enabled. Secure Boot helps ensure that the system only runs authentic software by verifying the digital signature of all boot components, and halting the boot process if signature verification fails.
      enable_integrity_monitoring - (Optional) Defines whether the instance has integrity monitoring enabled. Enables monitoring and attestation of the boot integrity of the instance. The attestation is performed against the integrity policy baseline. This baseline is initially derived from the implicitly trusted boot image when the instance is created.
    tags - The list of instance tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during cluster or node pool creation. Each tag within the list must comply with RFC1035.
    taint supports:
      key - (Required) Key for the taint.
      value - (Required) Value for the taint.
      effect - (Required) Effect for the taint. Possible values are "NO_SCHEDULE", "PREFER_NO_SCHEDULE" and "NO_EXECUTE".
    workload_metadata_config_mode - (Optional) The workload metadata configuration for this node.
    kubelet_config:
      cpu_manager_policy - (Optional) The CPU management policy on the node. Available values are "none", "static" and "default". The default is "none".
      cpu_cfs_quota - (Optional) Whether the CPU CFS quota is enabled. The default is false.
      cpu_cfs_quota_period - (Optional) The CPU CFS quota period value. Specified as a sequence of decimal numbers, each with optional fraction and a unit suffix, such as "300ms". Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h". The value must be a positive duration.
      pod_pids_limit - (Optional) The maximum number of PIDs in a pod. The default is -1.
    linux_node_config_sysctls - (Optional) The map of sysctl values to be set on the node.
    cgroup_mode -  Possible cgroup modes that can be used. Accepted values are:
CGROUP_MODE_UNSPECIFIED: CGROUP_MODE_UNSPECIFIED is when unspecified cgroup configuration is used. The default for the GKE node OS image will be used.
CGROUP_MODE_V1: CGROUP_MODE_V1 specifies to use cgroupv1 for the cgroup configuration on the node image.
CGROUP_MODE_V2: CGROUP_MODE_V2 specifies to use cgroupv2 for the cgroup configuration on the node image.
    node_group - (Optional) The name of the node group from which the node is created. If specified, the node will be created in the node group.
    sole_tenant_config:
      node_affinity supports:
        key - (Required) The key for the node affinity label.
        operator - (Required) The operator for node affinity. Possible values are "IN" and "NOT_IN".
        values - (Required) The values for the node affinity label.
    advanced_machine_features:
      threads_per_core - (Optional) The number of threads per core in the node. The default is 1.    
  EOF
  type = object({
    disk_size_gb                = optional(number, 100)
    disk_type                   = optional(string, "pd-standard")
    enable_confidential_storage = optional(bool)
    ephemeral_storage_config = optional(object({
      local_ssd_count = number
    }))
    ephemeral_storage_local_ssd_config = optional(object({
      local_ssd_count = number
    }))
    fast_socket_enabled = optional(bool)
    local_nvme_ssd_block_config = optional(object({
      local_ssd_count = optional(number)
    }))
    logging_variant     = optional(string)
    gcfs_config_enabled = optional(bool)
    gvnic_enabled       = optional(bool)
    guest_accelerator = optional(object({
      count = number
      type  = string
      gpu_driver_installation_config = optional(object({
        gpu_driver_version = string
      }))
      gpu_partition_size = optional(number)
      gpu_sharing_config = optional(object({
        gpu_sharing_strategy       = string
        max_shared_clients_per_gpu = number
      }))
    }))
    image_type       = optional(string)
    labels           = optional(map(string))
    resource_labels  = optional(map(string))
    local_ssd_count  = optional(number, 0)
    machine_type     = optional(string, "e2-medium")
    metadata         = optional(map(string))
    min_cpu_platform = optional(string)
    oauth_scopes     = optional(list(string))
    preemptible      = optional(bool, false)
    reservation_affinity = optional(object({
      consume_reservation_type = string
      key                      = optional(string)
      values                   = optional(list(string))
    }))
    spot                = optional(bool, false)
    sandbox_config_type = optional(string)
    boot_disk_kms_key   = optional(string)
    service_account     = optional(string)
    shielded_instance_config = optional(object({
      enable_secure_boot          = optional(bool, false)
      enable_integrity_monitoring = optional(bool, true)
    }))
    tags = list(string)
    taint = optional(list(object({
      key    = string
      value  = string
      effect = string
    })))
    workload_metadata_config_mode = optional(string)
    kubelet_config = optional(object({
      cpu_manager_policy   = string
      cpu_cfs_quota        = optional(bool)
      cpu_cfs_quota_period = optional(string)
      pod_pids_limit       = optional(number)
    }))
    linux_node_config_sysctls     = optional(map(string))
    linux_node_config_cgroup_mode = optional(string)
    node_group                    = optional(string)
    sole_tenant_config = optional(object({
      node_affinity = list(object({
        key      = string
        operator = string
        values   = list(string)
      }))
    }))
    advanced_machine_features = optional(object({
      threads_per_core = optional(number)
    }))
  })
  default = null
}

variable "node_pool_defaults" {
  description = <<EOF
  Node_config_defaults block supports the following:
  logging_variant - (Optional) The type of logging agent that is deployed by default for newly created node pools in the cluster. Valid values include DEFAULT and MAX_THROUGHPUT. See Increasing logging agent throughput for more information.".
  gcfs_config_enabled - (Optional) Whether the GKE Filestore CSI Driver is enabled for the node pool.
  EOF
  type = object({
    node_config_defaults = optional(object({
      logging_variant     = optional(string)
      gcfs_config_enabled = optional(bool)
    }))
  })
  default = null
}

variable "node_pool_auto_config" {
  description = "Network_tags for the node pool"
  type = object({
    network_tags = optional(map(string))
  })
  default = null
}

variable "node_version" {
  description = "The Kubernetes version on the nodes. Must either be unset or set to the same value as min_master_version on create. Defaults to the default version set by GKE which is not necessarily the latest version. This only affects nodes in the default node pool. While a fuzzy version can be specified, it's recommended that you specify explicit versions as Terraform will see spurious diffs when fuzzy versions are used. See the google_container_engine_versions data source's version_prefix field to approximate fuzzy versions in a Terraform-compatible way. To update nodes in other node pools, use the version attribute on the node pool."
  type        = string
  default     = null
}

variable "notification_config" {
  description = <<EOF
  Notification_config block supports the following:
  pubsub_enabled - (Required) Whether to send notifications about the cluster to the Google Cloud Console. If this field is enabled, the locations field must be specified.
  pubsub_topic - (Optional) The desired Pub/Sub topic to which notifications will be sent by GKE. If pubsub_enabled is enabled, this field is required.
  filter_event_type - (Optional) The desired Pub/Sub topic to which notifications will be sent by GKE. If pubsub_enabled is enabled, this field is required.
  EOF
  type = object({
    pubsub_enabled    = bool
    pubsub_topic      = optional(string)
    filter_event_type = optional(string)
  })
  default = null
}

variable "confidential_nodes_enabled" {
  description = "Enable Confidential GKE Nodes for this cluster, to enforce encryption of data in-use."
  type        = bool
  default     = false
}

variable "pod_security_policy_config_enabled" {
  description = "Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created."
  type        = bool
  default     = false
}

variable "authenticator_groups_config_security_group" {
  description = "The name of the RBAC security group for use with Google security groups in Kubernetes RBAC. Group name must be in format gke-security-groups@yourdomain.com."
  type        = string
  default     = null
}

variable "private_cluster_config" {
  description = <<EOF
  Private_cluster_config block supports the following:
  enable_private_nodes - (Optional) Whether the master's internal IP address is used as the cluster endpoint. If enabled, the master can only be accessed from internal IP addresses. This option is useful for security-sensitive workloads. Default is false.
  enable_private_endpoint - (Optional) Whether the master's internal IP address is used as the cluster endpoint. If enabled, the master can only be accessed from internal IP addresses. This option is useful for security-sensitive workloads. Default is false.
  master_ipv4_cidr_block - (Optional) The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters, as well as the ILB used to expose the master to the internet. This range must not overlap with any other ranges in use within the cluster's network. If left blank, the default value of '
  master_global_access_config_enabled - (Optional) Whether the master's internal IP address is used as the cluster endpoint. If enabled, the master can only be accessed from internal IP addresses. This option is useful for security-sensitive workloads. Default is false.
  EOF
  type = object({
    enable_private_nodes                = optional(bool)
    enable_private_endpoint             = optional(bool)
    master_ipv4_cidr_block              = optional(string)
    master_global_access_config_enabled = optional(bool)
  })
  default = null
}

variable "cluster_telemetry_type" {
  description = "Telemetry integration for the cluster. Supported values (ENABLED, DISABLED, SYSTEM_ONLY); SYSTEM_ONLY (Only system components are monitored and logged) is only available in GKE versions 1.15 and later."
  type        = string
  default     = null
}

variable "project" {
  description = "The ID of the project in which to create the node pool."
  type        = string
}

variable "release_channel" {
  description = "Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters. When updating this field, GKE imposes specific version requirements. See Selecting a new release channel for more details; the google_container_engine_versions datasource can provide the default version for a channel. Note that removing the release_channel field from your config will cause Terraform to stop managing your cluster's release channel, but will not unenroll it. Instead, use the UNSPECIFIED channel."
  type        = string
  validation {
    condition     = contains(["UNSPECIFIED", "RAPID", "REGULAR", "STABLE"], var.release_channel)
    error_message = "The possible values for release_channel are UNSPECIFIED, RAPID, REGULAR and STABLE."
  }
  default = "UNSPECIFIED"
}

variable "remove_default_node_pool" {
  description = "If true, deletes the default node pool upon cluster creation. If you're using google_container_node_pool resources with no default node pool, this should be set to true, alongside setting initial_node_count to at least 1."
  type        = bool
  default     = false
}

variable "resource_labels" {
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster."
  type        = map(string)
  default     = null
}

variable "cost_management_config_enabled" {
  description = "Whether to enable the cost allocation feature."
  type        = bool
  default     = false
}

variable "resource_usage_export_config" {
  description = <<EOF
  Resource_usage_export_config block supports the following:
  bigquery_destination_dataset_id - The ID of a BigQuery Dataset. If set, the cluster's usage will be exported to this BigQuery Dataset. The project that owns this BigQuery Dataset must be the same as the project of the cluster. If not set, no usage will be exported.
  enable_network_egress_metering - (Optional) Whether to enable network egress metering for this cluster. If enabled, a daemonset will be created in the cluster to meter network egress traffic.
  enable_resource_consumption_metering - (Optional) Whether to enable resource consumption metering on this cluster. If enabled, a second BigQuery dataset will be created to store resource consumption data.
  EOF
  type = object({
    bigquery_destination_dataset_id      = string
    enable_network_egress_metering       = optional(bool)
    enable_resource_consumption_metering = optional(bool)
  })
  default = null
}

variable "subnetwork" {
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
  type        = string
  default     = null
}

variable "vertical_pod_autoscaling_enabled" {
  description = "Whether to enable autoscaling for the Vertical Pod Autoscaler."
  type        = bool
  default     = false
}

variable "workload_identity_config_pool" {
  description = "The workload identity pool to attach to the cluster."
  type        = string
  default     = null
}

variable "identity_service_config_enabled" {
  description = "Whether to enable the workload identity feature."
  type        = bool
  default     = null
}

variable "enable_intranode_visibility" {
  description = "Whether Intra-node visibility is enabled for this cluster."
  type        = bool
  default     = null
}

variable "enable_l4_ilb_subsetting" {
  description = "Whether L4 ILB Subsetting is enabled for this cluster."
  type        = bool
  default     = null
}

variable "enable_multi_networking" {
  description = "Whether Multi-Networking is enabled for this cluster."
  type        = bool
  default     = null
}

variable "enable_fqdn_network_policy" {
  description = "Whether FQDN Network Policy is enabled for this cluster."
  type        = bool
  default     = null
}

variable "private_ipv6_google_access" {
  description = "The desired state of IPv6 connectivity to Google Services. By default, no private IPv6 access to or from Google Services (all access will be via IPv4)."
  type        = string
  default     = null
}

variable "datapath_provider" {
  description = " The desired datapath provider for this cluster. This is set to LEGACY_DATAPATH by default, which uses the IPTables-based kube-proxy implementation. Set to ADVANCED_DATAPATH to enable Dataplane v2."
  type        = string
  validation {
    condition     = contains(["LEGACY_DATAPATH", "ADVANCED_DATAPATH"], var.datapath_provider)
    error_message = "The possible values for datapath_provider are LEGACY_DATAPATH and ADVANCED_DATAPATH."
  }
  default = "LEGACY_DATAPATH"
}

variable "default_snat_status_disabled" {
  description = "GKE SNAT DefaultSnatStatus contains the desired state of whether default sNAT should be disabled on the cluster, API doc."
  type        = bool
  default     = null
}

variable "dns_config" {
  description = <<EOF
  Dns_config block supports the following:
  cluster_dns - (Optional) The IP address of a DNS server used by the cluster. This should be set when use_cloud_dns is true.
  cluster_dns_domain - (Optional) The DNS domain for the cluster.
  cluster_dns_scope - (Optional) The scope of the cluster DNS server. Default is "GOOGLE_DEFAULT".
  EOF
  type = object({
    cluster_dns        = optional(string)
    cluster_dns_domain = optional(string)
    cluster_dns_scope  = optional(string)
  })
  default = null
}

variable "gateway_api_config_channel" {
  description = "Which Gateway Api channel should be used. CHANNEL_DISABLED, CHANNEL_EXPERIMENTAL or CHANNEL_STANDARD."
  type        = string
  validation {
    condition     = contains(["CHANNEL_DISABLED", "CHANNEL_EXPERIMENTAL", "CHANNEL_STANDARD"], var.gateway_api_config_channel)
    error_message = "The possible values for gateway_api_config_channel are CHANNEL_DISABLED, CHANNEL_EXPERIMENTAL, CHANNEL_STANDARD"
  }
  default = "CHANNEL_STANDARD"
}

variable "protect_config" {
  description = <<EOF
  Protect_config block supports the following:
  workload_vulnerability_mode - (Optional) The workload identity mode for the cluster. Default is "SECURE_WORKLOAD".
  workload_config_audit - (Optional) The workload identity mode for the cluster. Default is "SECURE_WORKLOAD".
  EOF
  type = object({
    workload_vulnerability_mode = optional(string)
    workload_config_audit       = optional(string)
  })
  default = null
}

variable "security_posture_config" {
  description = <<EOF
  Security_posture_config block supports the following:
  mode - (Optional) The security posture mode for the cluster. Default is "SECURE_CLUSTER".
  vulnerability_mode - (Optional) The vulnerability mode for the cluster. Default is "SECURE_CLUSTER".
  EOF
  type = object({
    mode               = optional(string)
    vulnerability_mode = optional(string)
  })
  default = null
}

variable "fleet_project" {
  description = "The name of the Fleet host project where this cluster will be registered."
  type        = string
  default     = null
}

variable "workload_alts_config_enable" {
  description = "Whether the alts handshaker should be enabled or not for direct-path. Requires Workload Identity (workloadPool) must be non-empty)."
  type        = bool
  default     = null
}

#### Variables for Node Pool ####

variable "node_pool_name" {
  description = "Name of the node pool. If omitted, Terraform will assign a random, unique name."
  type        = string
}

variable "node_pool_node_count" {
  description = "The initial number of nodes for the pool. In regional or multi-zonal clusters, this is the number of nodes per zone. Changing this will force recreation of the resource. WARNING: Resizing your node pool manually may change this value in your existing cluster, which will trigger destruction and recreation on the next Terraform run (to rectify the discrepancy). If you don't need this value, don't set it. If you do need it,"
  type        = number
  default     = 1
}

variable "node_pool_autoscaling" {
  description = <<EOF
  Node_pool_autoscaling block supports the following:
  min_node_count - (Optional) Minimum number of nodes in the NodePool. Must be >= 1 and <= max_node_count. Cannot be used with total_min_node_count.
  max_node_count - (Optional) Maximum number of nodes in the NodePool. Must be >= min_node_count. Cannot be used with total_max_node_count.
  total_min_node_count - (Optional) Minimum number of nodes in the NodePool's autoscaler. Must be >= 1 and <= total_max_node_count. Cannot be used with min_node_count.
  total_max_node_count - (Optional) Maximum number of nodes in the NodePool's autoscaler. Must be >= total_min_node_count. Cannot be used with max_node_count.
  location_policy - (Optional) The location of the NodePool. If not specified, the cluster-level location is used. If the cluster-level location is not specified, the cluster location is used.
  EOF
  type = object({
    min_node_count       = optional(number)
    max_node_count       = optional(number)
    total_min_node_count = optional(number)
    total_max_node_count = optional(number)
    location_policy      = optional(string)
  })
  default = null
}

variable "node_pool_confidential_nodes_enabled" {
  description = "Enable Confidential GKE Nodes for this node pool, to enforce encryption of data in-use."
  type        = bool
  default     = false
}

variable "node_pool_initial_node_count" {
  description = "The initial number of nodes for the pool. In regional or multi-zonal clusters, this is the number of nodes per zone. Changing this will force recreation of the resource. WARNING: Resizing your node pool manually may change this value in your existing cluster, which will trigger destruction and recreation on the next Terraform run (to rectify the discrepancy). If you don't need this value, don't set it. If you do need it,"
  type        = number
  default     = null
}

variable "node_pool_management" {
  description = <<EOF
  Node_pool_management block supports the following:
  auto_repair - (Optional) Whether the nodes will be automatically repaired.
  auto_upgrade - (Optional) Whether the nodes will be automatically upgraded.
  EOF
  type = object({
    auto_repair  = optional(bool)
    auto_upgrade = optional(bool)
  })
  default = null
}

variable "node_pool_max_pods_per_node" {
  description = "The maximum number of pods per node in this node pool. Note that this does not work on node pools which are route-based - that is, node pools belonging to clusters that do not have IP Aliasing enabled. "
  type        = number
  default     = null
}

variable "node_pool_node_locations" {
  description = "The list of zones in which the node pool's nodes should be located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. If unspecified, the cluster-level node_locations will be used."
  type        = list(string)
  default     = null
}

variable "node_pool_name_prefix" {
  description = "Creates a unique name for the node pool beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = null
}

variable "node_pool_node_config" {
  description = <<EOF
  Node_config block supports the following:
  disk_size_gb - (Optional) Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. If unspecified, the default disk size is 100GB.
  disk_type - (Optional) Type of the disk attached to each node (e.g. 'pd-standard', 'pd-ssd' or 'pd-balanced'). If unspecified, the default disk type is 'pd-standard'
  enable_confidential_storage - (Optional) Whether the nodes are created as confidential VMs.
  ephemeral_storage_config:
    local_ssd_count - (Optional) The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on the machine type of the node. The minimum value allowed is 0. If not specified, the default is 0.
  ephemeral_storage_local_ssd_config:
    local_ssd_count - (Optional) The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on the machine type of the node. The minimum value allowed is 0. If not specified, the default is 0.
  fast_socket_enabled - (Optional) Whether the node's runtime performance is optimized for high performance.
  local_nvme_ssd_block_config:
    local_ssd_count - (Optional) The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on the machine type of the node. The minimum value allowed is 0. If not specified, the default is 0.
  logging_variant - Parameter for specifying the type of logging agent used in a node pool. This will override any cluster-wide default value. Valid values include DEFAULT and MAX_THROUGHPUT
  gcfs_config_enabled - (Optional) Whether the GKE Filestore CSI Driver is enabled for the node pool.
  gvnic_enabled - (Optional) Whether the GvNIC feature is enabled for the node pool.
  guest_accelerator supports following:
    count - (Optional) The number of the guest accelerator cards exposed to this instance.
    type - (Optional) The type of the guest accelerator cards exposed to this instance. The default is "nvidia-tesla-v100".
  gpu_driver_installation_config:
    gpu_driver_version - (Optional) The GPU driver version to install on the node. The default is the latest supported version.
  gpu_partition_size - (Optional) Size of the GPU partition. If not specified, the default is 0.
  gpu_sharing_config:
    gpu_sharing_strategy - (Optional) The GPU sharing strategy. Possible values are "NO_SHARING", "SINGLE_INSTANCE" and "MULTI_INSTANCE". The default is "NO_SHARING".
    max_shared_clients_per_gpu - (Optional) The maximum number of instances that can share a single physical GPU. The default is 0.
  image_type - (Optional) The image type to use for this node. Note that for a given image type, the latest version of it will be used.
  labels - (Optional) The map of labels to be attached to this node.
  resource_labels - (Optional) The map of resource labels to be attached to this node.
  local_ssd_count - (Optional) The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on the machine type of the node. The minimum value allowed is 0. If not specified, the default is 0.
  machine_type - (Optional) The name of a Google Compute Engine machine type. The default is "e2-medium".
  metadata - (Optional) The metadata key/value pairs assigned to instances in the cluster.
  min_cpu_platform - (Optional) The minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. Applicable values are the friendly names of CPU platforms, such as minCpuPlatform: "Intel Haswell" or minCpuPlatform: "Intel Sandy Bridge". For more information, read how to specify min CPU platform.
  oauth_scopes - (Optional) The set of Google API scopes to be made available on all of the node VMs under the "default" service account. The default is "https://www.googleapis.com/auth/cloud-platform".
  preemptible - (Optional) Whether the nodes are created as preemptible VM instances. The default is false.
  reservation_affinity:
    consume_reservation_type - (Optional) Corresponds to the type of reservation to consume. Possible values are "ANY_RESERVATION" and "SPECIFIC_RESERVATION". The default is "ANY_RESERVATION".
    key - (Optional) Corresponds to the label key of a reservation resource. The key must be empty if consume_reservation_type is "ANY_RESERVATION".
    values - (Optional) Corresponds to the label values of a reservation resource. The values must be 1:1 with key.
  spot - (Optional) Whether the nodes are created as preemptible VM instances. The default is false.
  sandbox_config_type - (Optional) The sandbox configuration for this node.
  boot_disk_kms_key - (Optional) The Customer Managed Encryption Key used to encrypt the boot disk attached to the node. The Customer Managed Encryption Key must be in the same region as the cluster. When specified, the node boot disk will be encrypted with the provided Customer Managed Encryption Key using Google Cloud Storage encryption. If unspecified, the boot disk will be encrypted with Google default encryption.
  service_account - (Optional) The Google Cloud Platform Service Account to be used by the node VMs. If no Service Account is specified, the "default" service account is used.
  shielded_instance_config:
    enable_secure_boot - (Optional) Defines whether the instance has Secure Boot enabled. Secure Boot helps ensure that the system only runs authentic software by verifying the digital signature of all boot components, and halting the boot process if signature verification fails.
    enable_integrity_monitoring - (Optional) Defines whether the instance has integrity monitoring enabled. Enables monitoring and attestation of the boot integrity of the instance. The attestation is performed against the integrity policy baseline. This baseline is initially derived from the implicitly trusted boot image when the instance is created.
  tags - The list of instance tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during cluster or node pool creation. Each tag within the list must comply with RFC1035.
  taint supports:
    key - (Required) Key for the taint.
    value - (Required) Value for the taint.
    effect - (Required) Effect for the taint. Possible values are "NO_SCHEDULE", "PREFER_NO_SCHEDULE" and "NO_EXECUTE".
  workload_metadata_config_mode - (Optional) The workload metadata configuration for this node.
  kubelet_config:
    cpu_manager_policy - (Optional) The CPU management policy on the node. Available values are "none", "static" and "default". The default is "none".
    cpu_cfs_quota - (Optional) Whether the CPU CFS quota is enabled. The default is false.
    cpu_cfs_quota_period - (Optional) The CPU CFS quota period value. The default is "100ms".
  linux_node_config_sysctls - (Optional) The map of sysctl values to be set on the node.
  node_group - (Optional) The name of the node group from which the node is created. If specified, the node will be created in the node group.
  sole_tenant_config:
    node_affinity supports:
      key - (Required) The key for the node affinity label.
      operator - (Required) The operator for node affinity. Possible values are "IN" and "NOT_IN".
      values - (Required) The values for the node affinity label.
  advanced_machine_features:
    threads_per_core - (Optional) The number of threads per core in the node. The default is 1.

  EOF
  type = object({
    disk_size_gb                = optional(number, 100)
    disk_type                   = optional(string, "pd-standard")
    enable_confidential_storage = optional(bool)
    ephemeral_storage_config = optional(object({
      local_ssd_count = number
    }))
    ephemeral_storage_local_ssd_config = optional(object({
      local_ssd_count = number
    }))
    fast_socket_enabled = optional(bool)
    local_nvme_ssd_block_config = optional(object({
      local_ssd_count = optional(number)
    }))
    logging_variant     = optional(string)
    gcfs_config_enabled = optional(bool)
    gvnic_enabled       = optional(bool)
    guest_accelerator = optional(object({
      count = number
      type  = string
      gpu_driver_installation_config = optional(object({
        gpu_driver_version = string
      }))
      gpu_partition_size = optional(number)
      gpu_sharing_config = optional(object({
        gpu_sharing_strategy       = string
        max_shared_clients_per_gpu = number
      }))
    }))
    image_type       = optional(string)
    labels           = optional(map(string))
    resource_labels  = optional(map(string))
    local_ssd_count  = optional(number, 0)
    machine_type     = optional(string, "e2-medium")
    metadata         = optional(map(string))
    min_cpu_platform = optional(string)
    oauth_scopes     = optional(list(string))
    preemptible      = optional(bool, false)
    reservation_affinity = optional(object({
      consume_reservation_type = string
      key                      = optional(string)
      values                   = optional(list(string))
    }))
    spot                = optional(bool, false)
    sandbox_config_type = optional(string)
    boot_disk_kms_key   = optional(string)
    service_account     = optional(string)
    shielded_instance_config = optional(object({
      enable_secure_boot          = optional(bool, false)
      enable_integrity_monitoring = optional(bool, true)
    }))
    tags = optional(list(string))
    taint = optional(list(object({
      key    = string
      value  = string
      effect = string
    })))
    workload_metadata_config_mode = optional(string)
    kubelet_config = optional(object({
      cpu_manager_policy   = string
      cpu_cfs_quota        = optional(bool)
      cpu_cfs_quota_period = optional(string)
      pod_pids_limit       = optional(number)
    }))
    linux_node_config_sysctls     = optional(map(string))
    linux_node_config_cgroup_mode = optional(string)
    node_group                    = optional(string)
    sole_tenant_config = optional(object({
      node_affinity = list(object({
        key      = string
        operator = string
        values   = list(string)
      }))
    }))
    advanced_machine_features = optional(object({
      threads_per_core = number
    }))
  })
  default = null
}

variable "node_pool_network_config" {
  description = <<EOF
  Node_pool_network_config block supports the following:
  create_pod_range - (Optional) Whether to create a new pod range for the node pool. If false, the cluster-level default pod range will be used.
  enable_private_nodes - (Optional) Whether the nodes are created as private nodes. If enabled, the nodes will get internal IP addresses only.
  pod_ipv4_cidr_block - (Optional) The IP address range for the pods in this node pool. If left blank, the default value of '
  pod_range - (Optional) The name of the pod range to use for the node pool. If left blank, the default name of "default-pool" will be used.
  additional_node_network_configs supports:
    network - (Optional) The name of the network to which the node pool is connected. If left blank, the default network will be used.
    subnetwork - (Optional) The name of the subnetwork to which the node pool is connected. If left blank, the default subnetwork will be used.
  additional_pod_network_configs supports:
    subnetwork          - (Optional) The name of the subnetwork to which the node pool is connected. If left blank, the default subnetwork will be used.
    secondary_pod_range - (Optional) The name of the secondary pod range to use for the node pool. If left blank, the default name of "default-pool" will be used.
    max_pods_per_node   - (Optional) The maximum number of pods per node in this node pool. If left blank, the default value of 110 will be used.    
  EOF
  type = object({
    create_pod_range     = optional(bool)
    enable_private_nodes = optional(bool)
    pod_ipv4_cidr_block  = optional(string)
    pod_range            = optional(string)
    additional_node_network_configs = object({
      network    = optional(string)
      subnetwork = optional(string)
    })
    additional_pod_network_configs = object({
      subnetwork          = optional(string)
      secondary_pod_range = optional(string)
      max_pods_per_node   = optional(number)
    })
  })
  default = null
}

variable "node_pool_upgrade_settings" {
  description = <<EOF
  Node_pool_upgrade_settings block supports the following:
  max_surge - (Optional) The maximum number of nodes that can be created beyond the current size of the node pool during the upgrade process. The default is 1.
  max_unavailable - (Optional) The maximum number of nodes that can be simultaneously unavailable during the upgrade process. The default is 0.
  EOF
  type = object({
    max_surge       = optional(string)
    max_unavailable = optional(string)
  })
  default = null
}

variable "node_pool_version" {
  description = "The Kubernetes version for the nodes in this pool. Note that if this field and auto_upgrade are both specified, they will fight each other for what the node version should be, so setting both is highly discouraged. While a fuzzy version can be specified, it's recommended that you specify explicit versions as Terraform will see spurious diffs when fuzzy versions are used. See the google_container_engine_versions data source's version_prefix field t"
  type        = string
  default     = null
}

variable "node_pool_placement_policy" {
  description = <<EOF
  Node_pool_placement_policy block supports the following:
  type - (Optional) The type of the placement policy. The default is "UNSPECIFIED".
  policy_name - (Optional) The name of the placement policy. The default is "UNSPECIFIED".
  tpu_topology - (Optional) The topology of the TPU. The default is "UNSPECIFIED".
  EOF
  type = object({
    type         = string
    policy_name  = optional(string)
    tpu_topology = optional(string)
  })
  default = null
}

variable "node_pool_queued_provisioning_enabled" {
  description = "Makes nodes obtainable through the ProvisioningRequest API exclusively."
  type        = bool
  default     = null
}

