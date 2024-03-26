#--------------------------------azure bastion---------------------------------------------------------#
resource "azurerm_bastion_host" "bastion_host" {
  name                   = var.name
  location               = var.location
  resource_group_name    = var.resource_group_name
  copy_paste_enabled     = var.copy_paste_enabled
  file_copy_enabled      = var.sku == "Standard" ? var.file_copy_enabled : false //file_copy_enabled is only supported when sku is Standard
  sku                    = var.sku
  ip_connect_enabled     = var.sku == "Standard" ? var.ip_connect_enabled : false     //ip_connect_enabled is only supported when sku is Standard.
  scale_units            = var.sku == "Standard" ? var.scale_units : 2                //scale_units only can be changed when sku is Standard. scale_units is always 2 when sku is Basic
  shareable_link_enabled = var.sku == "Standard" ? var.shareable_link_enabled : false //shareable_link_enabled is only supported when sku is Standard
  tunneling_enabled      = var.sku == "Standard" ? var.tunneling_enabled : false      //tunneling_enabled is only supported when sku is Standard
  tags                   = var.tags

  ip_configuration {
    name                 = var.ip_name
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
}
