resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nerwork_security_group
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.security_rule != null ? values(each.value.security_rule) : []
    content {
      name                                       = security_rule.value.name
      description                                = try(security_rule.value.description, null)
      protocol                                   = try(security_rule.value.protocol, "*")
      source_port_range                          = try(security_rule.value.source_port_range, "*")
      destination_port_range                     = try(security_rule.value.destination_port_range, "*")
      source_address_prefix                      = try(security_rule.value.source_address_prefix, "*")
      destination_address_prefix                 = try(security_rule.value.destination_address_prefix, "*")
      access                                     = try(security_rule.value.access, "Allow")
      priority                                   = security_rule.value.priority
      direction                                  = try(security_rule.value.direction, "Inbound")
      source_port_ranges                         = try(security_rule.value.source_port_ranges, "*")
      destination_port_ranges                    = try(security_rule.value.destination_port_ranges, "*")
      source_address_prefixes                    = try(security_rule.value.source_address_prefixes, "*")
      destination_address_prefixes               = try(security_rule.value.destination_address_prefixes, "*")
      source_application_security_group_ids      = try(security_rule.value.source_application_security_group_ids, null)
      destination_application_security_group_ids = try(security_rule.value.destination_application_security_group_ids, null)
    }
  }

  tags = {
    environment = "Production"
  }
}

