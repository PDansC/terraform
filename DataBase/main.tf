
resource "azurerm_postgresql_server" "PGSQL" {
  name                = "dans-wl-pg-sql-db"
  location            = var.location
  resource_group_name = var.RGName

  administrator_login          = var.admin_Username
  administrator_login_password = var.admin_Password

  sku_name   = "GP_Gen5_2"
  version    = "11"
  storage_mb = 65536

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = false
}

resource "azurerm_private_endpoint" "DBPrivateEndpoint" {
  name                = "DBPrivateEndpoint"
  location            = var.location
  resource_group_name = var.RGName
  subnet_id           = var.privateSubnetId

  private_service_connection {
    name                              = "DBPrivateEndpointConnection"
    private_connection_resource_id    = azurerm_postgresql_server.PGSQL.id
    subresource_names                 = [ "postgresqlServer" ]
    is_manual_connection              = false
  }
}