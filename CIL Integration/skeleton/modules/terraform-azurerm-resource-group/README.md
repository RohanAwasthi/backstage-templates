<!-- BEGIN_TF_DOCS -->
## Introduction

A resource group is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group. You decide how you want to add resources to resource groups. You can add new resource group as well fetch the existing one.


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
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Whether to create resource group and use it for all networking resources | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region to keep all your resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Resource group ID |
| <a name="output_location"></a> [location](#output\_location) | Resource group location |
| <a name="output_name"></a> [name](#output\_name) | Resource group name |

## Module Usage

* You can call the specified Resource Group module in any script where you want to use it.
```
module "module_create_resource_group" {
  source                           = "../../modules/module_resource-group-creation/"
  create_resource_group            = var.create_resource_group
  resource_group_name              = var.resource_group_name
  location                         = var.location
  tags                             = var.tags
 
}
```
<!-- END_TF_DOCS -->
