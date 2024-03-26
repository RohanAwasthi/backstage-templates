# RG

variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  type        = bool
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "The location/region to keep all your resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(any)
}

# VNET

variable "create_virtual_network" {
  description = "Whether to create the virtual netwroks and use it for the networking subnets"
  type        = bool
  default     = false
}

variable "vnet" {
  description = <<EOF
  Details of Virtual Network:
    (Required) address_space - The address space that is used the virtual network. You can supply more than one address space.
    (Optional) bgp_community - The BGP community attribute in format <as-number>:<community-value>.
    (Optional) dns_servers - List of IP addresses of DNS servers.
    (Optional) edge_zone - Specifies the Edge Zone within the Azure Region where this Virtual Network should exist.
    (Optional) flow_timeout_in_minutes - The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    (Required) tags - A mapping of tags to assign to the resource.
    (Optional) ddos_protection_plan - A ddos_protection_plan block.
        (Required) id -  The ID of DDoS Protection Plan.
        (Required) enable - Enable/disable DDoS Protection Plan on Virtual Network.
    (Optional) encryption - A encryption block.
        (Required) enforcement - Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted.
  EOF
  type = map(object({
    address_space           = list(string)
    bgp_community           = optional(string)
    dns_servers             = optional(list(string))
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))
    encryption = optional(object({
      enforcement = string
    }))
    tags = map(string)
  }))
  default = {}
}

# SUBNET

variable "create_subnet" {
  description = "Whether to create the subnet"
  type        = bool
  default     = false
}

variable "subnets" {
  description = <<EOF
  List of object in which user have to define the detailes of Subnets:
    (Required) name - The name of the subnet.
    (Required) virtual_network_name - The name of the virtual network to which to attach the subnet.
    (Required) address_prefixes - The address prefixes to use for the subnet.
    (Optional) delegation - A delegation block.
      (Required) name - A name for this delegation.
      (Required) service_delegation - A service_delegation block as defined below.
        (Required) name - The name of service to delegate to.
        (Optional) actions - A list of Actions which should be delegated. This list is specific to the service to delegate to.
    (Optional) private_endpoint_network_policies_enabled - Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    (Optional) private_link_service_network_policies_enabled - (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    (Optional) service_endpoints - The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web.
    (Optional) service_endpoint_policy_ids - The list of IDs of Service Endpoint Policies to associate with the subnet.
  EOF
  type = map(object({
    name                 = string
    virtual_network_name = string
    address_prefixes     = list(string)
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    })))
    private_endpoint_network_policies_enabled     = optional(bool)
    private_link_service_network_policies_enabled = optional(bool)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
  }))
}

# PIP

variable "create_public_ip" {
  description = "Whether to create the public IP"
  type        = bool
  default     = false
}

variable "public_ip_name" {
  description = "(Required) Name of the public IP to be created"
  type        = string
}

variable "allocation_method" {
  description = "(Required) Defines the allocation method for this IP addres"
  type        = string
}

variable "pip_sku" {
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default     = "Basic"
}

variable "ip_version" {
  description = "(Optional) The IP Version to use, IPv6 or IPv4."
  type        = string
  default     = "IPv4"
}

variable "idle_timeout_in_minutes" {
  description = "(Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = null
}

variable "domain_name_label" {
  description = "(Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  default     = null
  type        = string
}

variable "generate_domain_name_label" {
  description = "Generate automatically the domain name label, if set to true, automatically generate a domain name label with the name"
  type        = bool
  default     = false
}

variable "reverse_fqdn" {
  description = "(Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
  type        = string
  default     = null
}

variable "zones" {
  description = "(Optional) The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. Defaults to Zone-Redundant."
  type        = list(string)
  default = []
  # default     = ["Zone-Redundant"]
}

variable "ip_tags" {
  description = "A mapping of IP tags to assign to the public IP."
  type        = map(any)
}

variable "ddos_protection_mode" {
  description = "(Optional) The DDoS protection mode. Defaults to Standard. Possible values are Basic and Standard."
  type        = string
  default     = "Standard"  
}

variable "ddos_protection_plan_id" {
  description = "(Optional) The ID of a DDoS Protection Plan which this Public IP should be associated with."
  type        = string
  default     = null
}

variable "public_ip_prefix_id" {
  description = "(Optional) If specified then public IP address allocated will be provided from the public IP prefix resource."
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "(optional)The SKU Tier that should be used for the Public IP."
  type        = string
  default = "Regional"
}

variable "edge_zone" {
  description = "(optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist."
  type        = string
  default     = null
}

# BASTION HOST

variable "name" {
  description = "Specifies the name of the Bastion Host."
  type        = string
}

variable "copy_paste_enabled" {
  description = "Copy/Paste feature enabled for the Bastion Host."
  type        = bool
  default     = true
}

variable "file_copy_enabled" {
  description = "Is File Copy feature enabled for the Bastion Host."
  type        = bool
  default     = false
}

variable "sku" {
  description = "The SKU of the Bastion Host. Accepted values are Basic and Standard."
  type        = string
  default     = "Basic"
}

variable "ip_connect_enabled" {
  description = "Is IP Connect feature enabled for the Bastion Host"
  type        = bool
  default     = false
}

variable "scale_units" {
  description = "The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50."
  type        = number
  default     = 2
}

variable "shareable_link_enabled" {
  description = "Is Shareable Link feature enabled for the Bastion Host."
  type        = bool
  default     = false
}

variable "tunneling_enabled" {
  description = " Is Tunneling feature enabled for the Bastion Host."
  type        = bool
  default     = false
}

variable "ip_name" {
  description = "The name of the IP configuration."
  type        = string
}