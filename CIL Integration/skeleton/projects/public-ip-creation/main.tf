module "resource_group" {
  source                = "../../modules/terraform-azurerm-resource-group/"
  create_resource_group = var.create_resource_group
  name                  = var.resource_group_name
  location              = var.location
  tags                  = var.tags
}

module "public_ip" {
  source                  = "../../modules/terraform-azurerm-public-ip"
  resource_group_name     = module.resource_group.name
  location                = module.resource_group.location
  public_ip_name          = var.public_ip_name
  allocation_method       = var.allocation_method
  sku                     = var.sku
  ip_version              = var.ip_version
  domain_name_label       = var.domain_name_label
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  zones                   = var.zones
  reverse_fqdn            = var.reverse_fqdn
  public_ip_prefix_id     = var.public_ip_prefix_id
  edge_zone               = var.edge_zone
  sku_tier                = var.sku_tier
  ip_tags                 = var.ip_tags
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id
  tags                    = var.tags
  depends_on              = [module.resource_group]
}