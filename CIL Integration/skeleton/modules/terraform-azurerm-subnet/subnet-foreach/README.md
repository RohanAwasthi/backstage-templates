<!-- BEGIN_TF_DOCS -->

###### Last Updated[DD/MM/YYYY]: 24/01/2024

# <u> Introduction </u>
*  This module helps us in provisioning multiple subnets in multiple virtual networks.

## Prerequisite

1. Resource group
2. Virtual Network

## Requirements

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.87.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of object in which user have to define the detailes of Subnets:<br>    (Required) name - The name of the subnet.<br>    (Required) virtual\_network\_name - The name of the virtual network to which to attach the subnet.<br>    (Required) address\_prefixes - The address prefixes to use for the subnet.<br>    (Optional) delegation - A delegation block.<br>      (Required) name - A name for this delegation.<br>      (Required) service\_delegation - A service\_delegation block as defined below.<br>        (Required) name - The name of service to delegate to.<br>        (Optional) actions - A list of Actions which should be delegated. This list is specific to the service to delegate to.<br>    (Optional) private\_endpoint\_network\_policies\_enabled - Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.<br>    (Optional) private\_link\_service\_network\_policies\_enabled - (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.<br>    (Optional) service\_endpoints - The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web.<br>    (Optional) service\_endpoint\_policy\_ids - The list of IDs of Service Endpoint Policies to associate with the subnet. | <pre>map(object({<br>    name                 = string<br>    virtual_network_name = string<br>    address_prefixes     = list(string)<br>    delegation = optional(list(object({<br>      name = string<br>      service_delegation = object({<br>        name    = string<br>        actions = optional(list(string))<br>      })<br>    })))<br>    private_endpoint_network_policies_enabled     = optional(bool)<br>    private_link_service_network_policies_enabled = optional(bool)<br>    service_endpoints                             = optional(list(string))<br>    service_endpoint_policy_ids                   = optional(list(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | List of Subnet Ids |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | List of Subnet names. |
| <a name="output_subnet_name_and_subnet_id"></a> [subnet\_name\_and\_subnet\_id](#output\_subnet\_name\_and\_subnet\_id) | Subnet Id with respective Subnet Name(subnet\_name-virtual\_network\_name). |

## Module Usage 
* You can call the specified Subnet module in any script where you want to integrate it.
```
module "resource_group" {
  source                = "../../../modules/terraform-azure-resource-group"
  create_resource_group = var.create_resource_group
  name                  = var.name
  location              = var.location
  tags                  = var.tags
}

module "subnet" {
  source              = "../../../modules/terraform-azurerm-subnet/subnet-foreach"
  resource_group_name = module.resource_group.name
  subnets             = var.subnets
}

```
<!-- END_TF_DOCS -->