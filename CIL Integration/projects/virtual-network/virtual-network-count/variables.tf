variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  type        = bool
  default     = false
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
}

variable "vnet" {
  description = <<EOF
  Details of Virtual Network:
    (Required) name - The name of the virtual network.
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
  type = list(object({
    name                    = string
    address_space           = list(string)
    bgp_community           = optional(string)
    dns_servers             = optional(list(string))
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    tags                    = map(string)
    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))
    encryption = optional(object({
      enforcement = string
    }))
  }))
}
