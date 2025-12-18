module "rg" {
  source = "../../Module/azurerm_resource_group"
  rgs    = var.rgs

}

module "stg" {
  depends_on = [ module.rg ]
  source = "../../Module/azurerm_storage_account"
  storage_account = var.storage_account
  
}


module "vnet" {
  depends_on = [module.rg, ]
  source     = "../../Module/azurerm_vnet_subnet"
  vnet       = var.vnet
  subnets    = var.subnets
}


module "nsg" {
  depends_on             = [module.rg]
  source                 = "../../Module/azurerm_nsg"
  nerwork_security_group = var.nerwork_security_group

}

module "public_ip" {
  depends_on = [module.rg]
  source     = "../../Module/azurerm_public_ip"
  public_ip  = var.public_ip

}

module "nic" {
  depends_on        = [module.rg, module.vnet, module.public_ip]
  source            = "../../Module/azurerm_nic"
  network_interface = var.network_interface

}

module "vm" {
  depends_on = [module.rg, module.nic, module.vnet, module.kv]
  source     = "../../Module/azurerm_vm"
  vm         = var.vm

}

module "kv" {
  depends_on = [module.rg]
  source     = "../../Module/azurerm_key_vault"
  keyvault   = var.keyvault

}

module "sqlserver" {
  depends_on = [ module.kv, module.rg ]
  source = "../../Module/azurerm_sql_server"
  sql_servers = var.sql_servers
  
}

module "db" {
  depends_on = [ module.rg, module.sqlserver ]
  source = "../../Module/azurerm_sql_database"
  sql_databases = var.sql_databases
  
}