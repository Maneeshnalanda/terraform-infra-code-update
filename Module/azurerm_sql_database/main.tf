resource "azurerm_mssql_database" "database" {
  for_each = var.sql_databases

  name                        = each.value.databse_name 
  server_id                   = data.azurerm_mssql_server.myserver[each.key].id
  collation                   = each.value.collation
  sku_name                    = each.value.sku_name
  max_size_gb                 = each.value.max_size_gb
  auto_pause_delay_in_minutes = each.value.auto_pause_delay_in_minutes
  min_capacity                = each.value.min_capacity
  create_mode                 = each.value.create_mode
  creation_source_database_id = each.value.creation_source_database_id
  elastic_pool_id             = each.value.elastic_pool_id
  geo_backup_enabled          = each.value.geo_backup_enabled
  ledger_enabled              = each.value.ledger_enabled
  license_type                = each.value.license_type
  read_scale                  = each.value.read_scale
  sample_name                 = each.value.sample_name
  zone_redundant              = each.value.zone_redundant
  tags                        = each.value.tags
}
