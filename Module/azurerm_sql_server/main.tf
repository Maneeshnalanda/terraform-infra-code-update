data "azurerm_client_config" "current" {}


resource "azurerm_mssql_server" "sql" {
  for_each = var.sql_servers

  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  version             = each.value.version

  administrator_login          = data.azurerm_key_vault_secret.servername[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.serverpassword[each.key].value

  minimum_tls_version           = each.value.minimum_tls_version
  public_network_access_enabled = each.value.public_network_access_enabled

  tags = each.value.tags

  dynamic "azuread_administrator" {
    for_each = each.value.azuread_administrator != null ? [each.value.azuread_administrator] : []
    content {
      login_username              = azuread_administrator.value.login_username
      tenant_id                   = data.azurerm_client_config.current.tenant_id
      object_id                   = data.azurerm_client_config.current.object_id
      azuread_authentication_only = azuread_administrator.value.azuread_authentication_only
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
}
