output "resource_group_name" {
  description = "rg name"
  value = azurerm_resource_group.database.name
}

output "server_name" {
  description = "name of the SQL Server"
  value = azurerm_mssql_server.main.name
}

output "database_name" {
  description = "name of the SQL database"
  value = azurerm_mssql_database.main.name
}

output "connection_string" {
  description = "DB connection string"
  value = "server=${azurerm_mssql_server.main.fully_qualified_domain_name};Database=${azurerm_mssql_database.main.name}; User Id=${var.admin_login};Password=${var.admin_login_password};"
  sensitive = true
}