resource "azurerm_virtual_network" "vnet" {
  for_each                = var.vnet
  name                    = each.value.vnet_name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  address_space           = each.value.address_space
  dns_servers             = each.value.dns_servers
  bgp_community           = each.value.bgp_community
  edge_zone               = each.value.edge_zone
  flow_timeout_in_minutes = each.value.flow_timeout_in_minutes

  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pool != null ? each.value.ip_address_pool : []
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  dynamic "ddos_protection_plan" {
    for_each = each.value.ddos_protection_plan != null ? [each.value.ddos_protection_plan] : []
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  dynamic "encryption" {
    for_each = each.value.encryption != null ? [each.value.encryption] : []
    content {
      enforcement = encryption.value.enforcement
    }
  }

}

resource "azurerm_subnet" "subnet" {
  depends_on = [ azurerm_virtual_network.vnet ]
  for_each = var.subnets
  name                                          = each.value.name
  resource_group_name                           = each.value.resource_group_name
  virtual_network_name                          = each.value.virtual_network_name
  address_prefixes                              = lookup(each.value, "address_prefixes", null)
  default_outbound_access_enabled               = lookup(each.value, "default_outbound_access_enabled", true)
  private_endpoint_network_policies             = lookup(each.value, "private_endpoint_network_policies", "Disabled")
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", true)
  sharing_scope                                 = lookup(each.value, "sharing_scope", null)
  service_endpoints                             = lookup(each.value, "service_endpoints", [])
  service_endpoint_policy_ids                   = lookup(each.value, "service_endpoint_policy_ids", [])

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = lookup(delegation.value.service_delegation, "actions", null)
      }
    }
  }

}


