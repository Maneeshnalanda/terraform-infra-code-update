variable "sql_databases" {
  type = map(object({
    databse_name                        = string
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
