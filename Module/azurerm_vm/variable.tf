variable "vm" {
  description = "Map of VM configuration"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    size                = string
    # admin_username        = string
    kv_name = string
    secret_name = string
    secret_password= string
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
