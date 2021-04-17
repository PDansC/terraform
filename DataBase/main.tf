
resource "azurerm_postgresql_server" "PGSQL" {
  name                = "dans-wl-pg-sql-db"
  location            = var.location
  resource_group_name = var.RGName

  administrator_login          = var.admin_Username
  administrator_login_password = var.admin_Password

  sku_name   = "GP_Gen5_4"
  version    = "9.6"
  storage_mb = 65536

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = false
  ssl_minimal_tls_version_enforced = "TLS1_2"
}