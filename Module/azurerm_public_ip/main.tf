resource "azurerm_public_ip" "example" {
  for_each                = var.public_ip
  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  allocation_method       = each.value.allocation_method
  sku                     = try(each.value.sku, "Standard")
  sku_tier                = try(each.value.sku_tier, "Regional")
  ip_version              = try(each.value.ip_version, "IPv4")
  zones                   = try(each.value.zones, null)
  edge_zone               = try(each.value.edge_zone, null)
  ddos_protection_mode    = try(each.value.ddos_protection_mode, "VirtualNetworkInherited")
  ddos_protection_plan_id = try(each.value.ddos_protection_plan_id, null)
  domain_name_label       = try(each.value.domain_name_label, null)
  domain_name_label_scope = try(each.value.domain_name_label_scope, null)
  idle_timeout_in_minutes = try(each.value.idle_timeout_in_minutes, 4)
  ip_tags                 = try(each.value.ip_tags, null)
  public_ip_prefix_id     = try(each.value.public_ip_prefix_id, null)
  reverse_fqdn            = try(each.value.reverse_fqdn, null)
  tags                    = try(each.value.tags, null)
}