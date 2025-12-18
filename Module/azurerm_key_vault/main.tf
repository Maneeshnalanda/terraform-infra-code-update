data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  for_each                    = var.keyvault
  name                        = each.value.kv_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  sku_name                    = each.value.sku_name
  # rbac_authorization_enabled = each.value.rbac_authorization

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Delete",
      "Create",
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete",

    ]

    storage_permissions = [
      "Get",
      "List",
      "Delete"
    ]
  }
}


resource "azurerm_key_vault_secret" "vmusername" {
  depends_on   = [azurerm_key_vault.kv]
  for_each     = var.keyvault
  name         = each.value.secret_name
  value        = each.value.secret_user_value
  key_vault_id = azurerm_key_vault.kv[each.key].id
}


resource "azurerm_key_vault_secret" "vmpassword1" {
  depends_on   = [azurerm_key_vault.kv]
  for_each     = var.keyvault
  name         = each.value.secret_password
  value        = each.value.secret_password_value
  key_vault_id = azurerm_key_vault.kv[each.key].id
}


resource "azurerm_key_vault_secret" "servername" {
  depends_on   = [azurerm_key_vault.kv]
  for_each     = var.keyvault
  name         = each.value.secret_name
  value        = each.value.secret_user_value
  key_vault_id = azurerm_key_vault.kv[each.key].id
}

resource "azurerm_key_vault_secret" "serverpassword" {
  depends_on   = [azurerm_key_vault.kv]
  for_each     = var.keyvault
  name         = each.value.secret_password
  value        = each.value.secret_password_value
  key_vault_id = azurerm_key_vault.kv[each.key].id
}
