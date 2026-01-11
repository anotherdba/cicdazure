
locals {
  resource_suffix = "${var.environment}-${var.project_name}-database"


  common_tags = merge (
    var.tags,
    {
 
      project_name = var.project_name
      managed_by = "terraform"
      module_name = "compute"
    }
  )
}



resource "azurerm_resource_group" "database" {
  name = "rg-${local.resource_suffix}"
  location = var.location
  tags = local.common_tags
}

resource "azurerm_mssql_server" "main" {
  name                         = "sql-${var.environment}-${var.project_name}"
  resource_group_name          = azurerm_resource_group.database.name
  location                     = azurerm_resource_group.database.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password =  var.admin_login_password
  minimum_tls_version          = var.minimum_tls_version

}
        
resource "azurerm_mssql_database" "main" {
  name         = "db-${var.environment}-${var.project_name}"
  server_id    = azurerm_mssql_server.main.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name
  # enclave_type = "VBS"

 tags= local.common_tags


}


resource "azurerm_mssql_firewall_rule" "azure_services" {
  name = "AllowAzureServices"
    server_id    = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address = "0.0.0.0"
}