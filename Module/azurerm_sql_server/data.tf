data "azurerm_key_vault" "kv" {
  for_each = var.sql_servers
  name = each.value.kv_name
  resource_group_name = each.value.resource_group_name 
}

  
data "azurerm_key_vault_secret" "servername"{
  for_each = var.sql_servers
  name = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id

}

data "azurerm_key_vault_secret" "serverpassword" {
  for_each = var.sql_servers
  name = each.value.secret_password
  key_vault_id= data.azurerm_key_vault.kv[each.key].id
}