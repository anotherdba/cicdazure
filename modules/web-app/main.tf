
locals {
  resource_suffix = "${var.environment}-${var.project_name}-web-app"


  common_tags = merge (
    var.tags,
    {
 
      project_name = var.project_name
      managed_by = "terraform"
      module_name = "web-app"
    }
  )
}



resource "azurerm_resource_group" "web-app" {
  name = "rg-${local.resource_suffix}"
  location = var.location
  tags = local.common_tags
}

resource "azurerm_service_plan" "main" {
  name                = "plan-${var.environment}-${var.project_name}"
  location            = azurerm_resource_group.web-app.location
  resource_group_name = azurerm_resource_group.web-app.name
  os_type             = "Linux"
  sku_name            = var.app_service_sku
  tags= local.common_tags
  }


resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.environment}-${var.project_name}"
  location            = azurerm_resource_group.web-app.location
  resource_group_name = azurerm_resource_group.web-app.name
  service_plan_id = azurerm_service_plan.main.id


site_config {
  application_stack {
    node_version = "18-lts"
  }
  always_on = false
}
app_settings = var.database_connection_string != "" ? {
  "DATABASE_CONNECTION_STRING" =var.database_connection_string
}: {}
tags = local.common_tags
}


#Random string

resource "random_string" "name" {
  length = 6
  special = false
  upper = false
}



# resource "azurerm_mssql_server" "main" {
#   name                         = "sql-${var.environment}-${var.project_name}"
#   resource_group_name          = azurerm_resource_group.database.name
#   location                     = azurerm_resource_group.database.location
#   version                      = "12.0"
#   administrator_login          = var.admin_login
#   administrator_login_password =  var.admin_login_password
#   minimum_tls_version          = var.minimum_tls_version

# }




