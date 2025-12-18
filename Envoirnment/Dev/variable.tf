# RG Variable
variable "rgs" {
  type = map(object({
    rg_name    = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))

  }))
}

#  Storage Account
variable "storage_account" {
  type = map(object(
    {
      name                              = string
      resource_group_name               = string
      location                          = string
      account_tier                      = string
      account_replication_type          = string
      account_kind                      = optional(string)
      provisioned_billing_model_version = optional(string)
      cross_tenant_replication_enabled  = optional(bool)
      access_tier                       = optional(string)
      edge_zone                         = optional(string)
      https_traffic_only_enabled        = optional(bool)
      min_tls_version                   = optional(string)
      allow_nested_items_to_be_public   = optional(bool)
      shared_access_key_enabled         = optional(bool)
      public_network_access_enabled     = optional(bool)
      default_to_oauth_authentication   = optional(bool)
      is_hns_enabled                    = optional(bool)
      nfsv3_enabled                     = optional(bool)
      large_file_share_enabled          = optional(bool)
      local_user_enabled                = optional(bool)
      queue_encryption_key_type         = optional(string)
      table_encryption_key_type         = optional(string)
      infrastructure_encryption_enabled = optional(bool)
      allowed_copy_scope                = optional(string)
      sftp_enabled                      = optional(bool)
      dns_endpoint_type                 = optional(string)
      tags                              = optional(map(string))
      network_rules = optional(map(object({
        default_action = string
        bypass         = optional(list(string))
        ip_rules       = optional(list(string))
      })))

  }))

}


# Vnet variable
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

# Subnet
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


# NSG
variable "nerwork_security_group" {
  type = map(object({
    nsg_name            = string
    location            = string
    resource_group_name = string

    security_rule = optional(map(object({
      name                                       = string
      description                                = optional(string)
      protocol                                   = string
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      source_address_prefix                      = optional(string)
      source_address_prefixes                    = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      access                                     = string
      priority                                   = number
      direction                                  = string
    })))

    tags = optional(map(object(
      {
        environment = string

      }))
    )
  }))
}

# Public IP
variable "public_ip" {
  description = "Map of Public IP configuration"
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    allocation_method       = string
    zones                   = optional(list(string))
    edge_zone               = optional(string)
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)
    tags                    = optional(map(string))
  }))
}

# NIC
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

# Virtual machine

variable "vm" {
  description = "Map of VM configuration"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    size                = string
    # admin_username        = string
    kv_name         = string
    secret_name     = string
    secret_password = string
    # network_interface_ids = list(string)
    nic_name = string

    os_disk = object({
      caching              = string
      storage_account_type = string
    })

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    # admin_password                  = optional(string)
    disable_password_authentication = optional(bool)
    admin_ssh_key = optional(list(object({
      username   = string
      public_key = string
    })))
    boot_diagnostics = optional(list(object({
      storage_account_uri = string
    })))
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })))
    additional_capabilities = optional(list(object({
      ultra_ssd_enabled   = optional(bool)
      hibernation_enabled = optional(bool)
    })))
    termination_notification = optional(list(object({
      enabled = bool
      timeout = string
    })))
    computer_name              = optional(string)
    custom_data                = optional(string)
    encryption_at_host_enabled = optional(bool)
    priority                   = optional(string)
    zone                       = optional(string)
    provision_vm_agent         = optional(bool)
    allow_extension_operations = optional(bool)
    tags                       = optional(map(string))
  }))
}

# Keyvault

variable "keyvault" {
  description = "Map of keyvaults to create. Each value is an object with name, location, resource_group and secrets (list of objects { name, value })."
  type = map(object({
    kv_name                     = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = optional(bool, true)
    sku_name                    = string
    soft_delete_retention_days  = optional(number)
    purge_protection_enabled    = optional(bool, false)
    secret_name                 = string
    secret_password             = string
    secret_user_value           = string
    secret_password_value       = string
    # rbac_authorization          = optional(bool)
  }))
}

# sql server

variable "sql_servers" {
  description = "sql server"
  type = map(object({
    server_name         = string
    resource_group_name = string
    location            = string
    version             = string
    # administrator_login           = string
    # administrator_login_password  = string
    minimum_tls_version           = optional(string)
    public_network_access_enabled = optional(bool)
    tags                          = optional(map(string))
    secret_name                   = string
    secret_password               = string
    secret_user_value             = string
    secret_password_value         = string
    kv_name                       = string


    azuread_administrator = optional(object({
      login_username = string
      #   object_id                   = string
      #   tenant_id                   = optional(string)
      azuread_authentication_only = optional(bool)
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

  }))
}

#  sql database

variable "sql_databases" {
  type = map(object({
    databse_name                = string
    # server_id                   = string
    server_name                 = string
    resource_group_name         = string
    collation                   = optional(string)
    sku_name                    = optional(string)
    max_size_gb                 = optional(number)
    auto_pause_delay_in_minutes = optional(number)
    min_capacity                = optional(number)
    create_mode                 = optional(string)
    creation_source_database_id = optional(string)
    elastic_pool_id             = optional(string)
    geo_backup_enabled          = optional(bool)
    ledger_enabled              = optional(bool)
    license_type                = optional(string)
    read_scale                  = optional(bool)
    sample_name                 = optional(string)
    zone_redundant              = optional(bool)
    tags                        = optional(map(string))
  }))
}




