<!-- BEGIN_TF_DOCS -->
###### Last Updated[DD/MM/YYYY]: 29/02/2024

##  Introduction 
This module provisions following resource- AZURE BASTION HOST

1) The Azure Bastion service is a fully platform-managed PaaS service that you provision inside your virtual network.
2) Azure Bastion is a service you deploy that lets you connect to a virtual machine using your browser and the Azure portal, or via the native SSH or RDP client already installed on your local computer. 
3) When you connect via Azure Bastion, your virtual machines don't need a public IP address, agent, or special client software.

## Prerequisite

* Subnet Id
* Public IP Id

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
| [azurerm_bastion_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_copy_paste_enabled"></a> [copy\_paste\_enabled](#input\_copy\_paste\_enabled) | Copy/Paste feature enabled for the Bastion Host. | `bool` | `true` | no |
| <a name="input_file_copy_enabled"></a> [file\_copy\_enabled](#input\_file\_copy\_enabled) | Is File Copy feature enabled for the Bastion Host. | `bool` | `false` | no |
| <a name="input_ip_connect_enabled"></a> [ip\_connect\_enabled](#input\_ip\_connect\_enabled) | Is IP Connect feature enabled for the Bastion Host | `bool` | `false` | no |
| <a name="input_ip_name"></a> [ip\_name](#input\_ip\_name) | The name of the IP configuration. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Bastion Host. | `string` | n/a | yes |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | Reference to a Public IP Address to associate with this Bastion Host. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Bastion Host. | `string` | n/a | yes |
| <a name="input_scale_units"></a> [scale\_units](#input\_scale\_units) | The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50. | `number` | `2` | no |
| <a name="input_shareable_link_enabled"></a> [shareable\_link\_enabled](#input\_shareable\_link\_enabled) | Is Shareable Link feature enabled for the Bastion Host. | `bool` | `false` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Bastion Host. Accepted values are Basic and Standard. | `string` | `"Basic"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Reference to a subnet in which this Bastion Host has been created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |
| <a name="input_tunneling_enabled"></a> [tunneling\_enabled](#input\_tunneling\_enabled) | Is Tunneling feature enabled for the Bastion Host. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The FQDN for the Bastion Host. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Bastion Host. |

## Module Usage 

**Module usage with all arguments -**
```
module "azure-bastion" {
  source                 = "../../modules/terraform-azurerm-bastion-host"
  name                   = var.name
  location               = var.location
  resource_group_name    = var.resource_group_name
  copy_paste_enabled     = var.copy_paste_enabled
  file_copy_enabled      = var.file_copy_enabled
  sku                    = var.sku
  ip_connect_enabled     = var.ip_connect_enabled
  scale_units            = var.scale_units
  shareable_link_enabled = var.shareable_link_enabled
  tunneling_enabled      = var.tunneling_enabled
  tags                   = var.tags
  ip_name                = var.ip_name
  subnet_id              = data.azurerm_subnet.subnet_id.id
  public_ip_address_id   = data.azurerm_public_ip.Public_ip.*.id[0]

}
```

**Module usage with  only required arguments -**
```
module "azure_bastion" {
    source                 = "../../modules/terraform-azurerm-bastion-host"
    name                   = var.name
    location               = var.location
    resource_group_name    = var.resource_group_name
    tags = var.tags
    ip_name                = var.ip_name    
    subnet_id              = data.azurerm_subnet.subnet_id.id
    public_ip_address_id   = data.azurerm_public_ip.Public_ip.*.id[0]
}

```
<!-- END_TF_DOCS -->