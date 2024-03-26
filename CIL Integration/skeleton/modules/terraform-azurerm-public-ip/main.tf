
resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method

  # properties below are optional
  edge_zone               = var.edge_zone
  sku_tier                = var.sku_tier
  sku                     = var.sku
  ip_version              = var.ip_version
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  domain_name_label       = var.generate_domain_name_label ? var.public_ip_name : var.domain_name_label
  reverse_fqdn            = var.reverse_fqdn
  zones                   = var.zones
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id
  public_ip_prefix_id     = var.public_ip_prefix_id
  ip_tags                 = var.ip_tags
  tags                    = var.tags
}
