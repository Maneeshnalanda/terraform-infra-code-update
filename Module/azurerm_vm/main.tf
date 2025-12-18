resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vm

  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  size                            = each.value.size
  admin_username                  = data.azurerm_key_vault_secret.vmusername[each.key].value
  network_interface_ids           = [data.azurerm_network_interface.nic[each.key].id]
  admin_password                  = data.azurerm_key_vault_secret.vmpassword[each.key].value
  disable_password_authentication = each.value.disable_password_authentication
  computer_name                   = each.value.computer_name
  custom_data                     = each.value.custom_data    
  encryption_at_host_enabled      = each.value.encryption_at_host_enabled
  priority                        = each.value.priority 
  zone                            = each.value.zone
  provision_vm_agent              = each.value.provision_vm_agent   
  allow_extension_operations      = each.value.allow_extension_operations 
  tags                            = each.value.tags
  


  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  dynamic "admin_ssh_key" {
    for_each = each.value.admin_ssh_key != null ? each.value.admin_ssh_key : []
    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }

  dynamic "boot_diagnostics" {
    for_each = each.value.boot_diagnostics != null ? each.value.boot_diagnostics : []
    content {
      storage_account_uri = boot_diagnostics.value.storage_account_uri
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? each.value.identity : []
    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "additional_capabilities" {
    for_each = each.value.additional_capabilities != null ? each.value.additional_capabilities : []
    content {
      ultra_ssd_enabled   = try(additional_capabilities.value.ultra_ssd_enabled, false)
      hibernation_enabled = try(additional_capabilities.value.hibernation_enabled, false)
    }
  }


  dynamic "termination_notification" {
    for_each = each.value.termination_notification != null ? each.value.termination_notification : []
    content {
      enabled = termination_notification.value.enabled
      timeout = termination_notification.value.timeout
    }
  }
}
