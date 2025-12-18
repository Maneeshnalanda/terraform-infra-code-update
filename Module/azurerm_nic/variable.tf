variable "network_interface" {
  description = "Map of Network Interface configurations"
  type = map(object({
    name                           = string
    location                       = string
    resource_group_name            = string
    auxiliary_mode                 = optional(string)
    auxiliary_sku                  = optional(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    ip_forwarding_enabled          = optional(bool)
    accelerated_networking_enabled = optional(bool)
    internal_dns_name_label        = optional(string)
    tags                           = optional(map(string))

    ip_configuration = list(object({
      name                                               = string
      subnet_id                                          = optional(string)
      private_ip_address_version                         = optional(string)
      private_ip_address_allocation                      = string
      private_ip_address                                 = optional(string)
      public_ip_address_id                               = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      primary                                            = optional(bool)
      subnet_key                                         = optional(string)
      vnet_key                                           = optional(string)
      pip_name                                           = string
      subnet_name                                        = string
      virtual_network_name                               = string

    }))
  }))
}
