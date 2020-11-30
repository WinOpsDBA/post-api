resource "azurerm_resource_group" "rg1" {
  name     = "${var.core_name}-rg"
  location = var.location
}

resource "azurerm_storage_account" "storage1" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "sql1" {
  name                         = "${var.core_name}-sql"
  resource_group_name          = azurerm_resource_group.rg1.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.adminusername
  administrator_login_password = var.adminpassword

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage1.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage1.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }
}

resource "azurerm_sql_firewall_rule" "fw1" {
  name                = "FirewallRule1"
  resource_group_name = azurerm_resource_group.rg1.name
  server_name         = azurerm_sql_server.sql1.name
  start_ip_address    = "0.0.0.0" # var.allowed_ip
  end_ip_address      = "255.255.255.255" # var.allowed_ip
}

resource "azurerm_sql_database" "db1" {
  name                = "post-api"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = var.location
  server_name         = azurerm_sql_server.sql1.name
}