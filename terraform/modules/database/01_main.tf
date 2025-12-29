resource "azurerm_postgresql_flexible_server" "psqlflexibleserver" {
  name                          = "psql-${var.workload}-${var.environment}-${var.location}-001"
  resource_group_name           = var.rg_name
  location                      = var.rg_location
  version                       = "16"
  delegated_subnet_id           = var.db_snet_id
  private_dns_zone_id           = var.db_private_dns_zone_id
  public_network_access_enabled = false
  administrator_login           = "superuser1234"
  // TODO: ZMIENIC TO NA RANDOM HASLO 
  administrator_password        = "superuserpassword1234"
  zone                          = "1"

  storage_mb   = 32768
  storage_tier = "P4"

  sku_name   = "B_Standard_B1ms"
  depends_on = [var.db_private_link]

}

resource "azurerm_postgresql_flexible_server_database" "payments_db" {
  name      = "payments"
  server_id = azurerm_postgresql_flexible_server.psqlflexibleserver.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}