variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
}

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
