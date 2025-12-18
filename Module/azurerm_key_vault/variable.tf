variable "keyvault" {
  description = "Map of keyvaults to create. Each value is an object with name, location, resource_group and secrets (list of objects { name, value })."
  type = map(object({
    kv_name                     = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = optional(bool)
    sku_name                    = string
    soft_delete_retention_days  = optional(number)
    purge_protection_enabled    = optional(bool)
    secret_name                 = string
    secret_password             = string
    secret_user_value           = string
    secret_password_value       = string
    # rbac_authorization          = optional(bool)
  }))
}
