variable "vnet" {
  description = "Virtual network configuration"
  type = map(object({
    vnet_name               = string
    resource_group_name     = string
    location                = string
    address_space           = optional(list(string))
    bgp_community           = optional(string)
    dns_servers             = optional(list(string), [])
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)

    ip_address_pool = optional(list(object({
      id                     = string
      number_of_ip_addresses = string
    })))

    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))

    encryption = optional(object({
      enforcement = string
    }))



  }))
}


variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = optional(list(string))
    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))
    default_outbound_access_enabled               = optional(bool, true)
    private_endpoint_network_policies             = optional(string, "Disabled")
    private_link_service_network_policies_enabled = optional(bool, true)
    sharing_scope                                 = optional(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    })))
  }))
}

