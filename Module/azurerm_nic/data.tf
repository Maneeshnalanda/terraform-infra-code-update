data "azurerm_public_ip" "pip_id" {
  for_each            = var.network_interface
  name                = each.value.ip_configuration[0].pip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "subnet01" {
  for_each             = var.network_interface
  name                 = each.value.ip_configuration[0].subnet_name
  virtual_network_name = each.value.ip_configuration[0].virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
