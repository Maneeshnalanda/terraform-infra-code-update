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
