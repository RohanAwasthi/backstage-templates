<!-- BEGIN_TF_DOCS -->
## Introduction
You can use an Azure network security group to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol. For creating NSG rules we are using nsg_rules.csv file. This module gets its input for nsg rules via a csv file that contains the follwing headers
`nsg_name,rulename,priority,direction,access,protocol,source_port_range,destination_port_range,source_address_prefix,destination_address_prefix`

[nsg_rules](../../projects/network-security-group/nsg_rules.csv)

## Requirements
| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\terraform) | 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.87.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_csv_file_name_for_NSG"></a> [csv\_file\_name\_for\_NSG](#input\_csv\_file\_name\_for\_NSG) | Name of the CSV file where Network Security Rule details defined. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the network security group. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsg_name_and_nsg_id"></a> [nsg\_name\_and\_nsg\_id](#output\_nsg\_name\_and\_nsg\_id) | Map of nsg IDs with respect to nsg name. |

## Modules

~~~
module "resource_group" {
  source                = "../../modules/terraform-azure-resource-group"
  create_resource_group = var.create_resource_group
  name                  = var.resource_group_name
  location              = var.location
  tags                  = var.tags
}

module "network_security_group" {
  source                = "../../modules/terraform-azure-nsg"
  location              = module.resource_group.location
  resource_group_name   = module.resource_group.name
  csv_file_name_for_NSG = "nsg_rules.csv"
  tags                  = var.tags
}
~~~
<!-- END_TF_DOCS -->