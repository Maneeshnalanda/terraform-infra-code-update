resource "azurerm_network_interface" "nic" {
  for_each            = var.network_interface
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  auxiliary_mode                 = each.value.auxiliary_mode
  auxiliary_sku                  = each.value.auxiliary_sku
  dns_servers                    = each.value.dns_servers
  edge_zone                      = each.value.edge_zone
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled
  accelerated_networking_enabled = each.value.accelerated_networking_enabled
  internal_dns_name_label        = each.value.internal_dns_name_label
  tags                           = each.value.tags

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration != null ? each.value.ip_configuration : []
    content {
      name                                               = ip_configuration.value.name
      subnet_id                                          = data.azurerm_subnet.subnet01[each.key].id
      private_ip_address_version                         = ip_configuration.value.private_ip_address_version
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation
      private_ip_address                                 = ip_configuration.value.private_ip_address
      public_ip_address_id                               = data.azurerm_public_ip.pip_id[each.key].id
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id
      primary                                            = ip_configuration.value.primary
    }
  }
}

