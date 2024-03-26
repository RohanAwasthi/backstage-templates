variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
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
