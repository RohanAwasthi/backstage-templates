<!-- BEGIN_TF_DOCS -->
###### Last Updated[DD/MM/YYYY]: 31/01/2024

# <u> Introduction </u>
*  This module helps us in provisioning multiple virtual network.

## Prerequisite

1. Resource group

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
| [azurerm_virtual_network.vn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. | `string` | n/a | yes |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | Details of Virtual Network:<br>    (Required) address\_space - The address space that is used the virtual network. You can supply more than one address space.<br>    (Optional) bgp\_community - The BGP community attribute in format <as-number>:<community-value>.<br>    (Optional) dns\_servers - List of IP addresses of DNS servers.<br>    (Optional) edge\_zone - Specifies the Edge Zone within the Azure Region where this Virtual Network should exist.<br>    (Optional) flow\_timeout\_in\_minutes - The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.<br>    (Required) tags - A mapping of tags to assign to the resource.<br>    (Optional) ddos\_protection\_plan - A ddos\_protection\_plan block.<br>        (Required) id -  The ID of DDoS Protection Plan.<br>        (Required) enable - Enable/disable DDoS Protection Plan on Virtual Network.<br>    (Optional) encryption - A encryption block.<br>        (Required) enforcement - Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted. | <pre>map(object({<br>    address_space           = list(string)<br>    bgp_community           = optional(string)<br>    dns_servers             = optional(list(string))<br>    edge_zone               = optional(string)<br>    flow_timeout_in_minutes = optional(number)<br>    ddos_protection_plan = optional(object({<br>      id     = string<br>      enable = bool<br>    }))<br>    encryption = optional(object({<br>      enforcement = string<br>    }))<br>    tags = map(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_name_and_vnet_guid"></a> [vnet\_name\_and\_vnet\_guid](#output\_vnet\_name\_and\_vnet\_guid) | Map of Vnet GUIDs with respective to Vnet name. |
| <a name="output_vnet_name_and_vnet_id"></a> [vnet\_name\_and\_vnet\_id](#output\_vnet\_name\_and\_vnet\_id) | Map of Vnet IDs with respective to Vnet name. |

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

module "vnet" {
  source              = "../../../modules/terraform-azurerm-virtual-network/virtual-network-foreach"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet                = var.vnet
}
```
<!-- END_TF_DOCS -->