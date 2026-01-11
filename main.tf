


module "compute" {
  source                  = "./modules/compute"
  project_name            = "projkpi"
  team_name               = var.team_name
  environment             = var.environment
  location                = var.location
  address_space           = var.address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  vm_count                = var.vm_count
  vm_size                 = var.vm_size
  tags                    = var.tags
}


module "database" {
  source               = "./modules/database"
  server_name          = var.server_name
  db_name              = var.db_name
  admin_login          = var.admin_login
  admin_login_password = var.admin_login_password
  tags                 = var.tags
  project_name         = "projkpi"
  environment          = var.environment
}


module "web-app" {
  source       = "./modules/web-app"
  tags         = var.tags
  project_name = "projkpi"
  environment  = var.environment
  app_service_sku = var.app_service_sku
   database_connection_string =  module.database.connection_string
}





















#Configure the Azure provider features

# locals {
#   environment_config = {
#     default = {
#       vm_size = "Standard_B1s"
#       vm_count=1
#     }

#       dev = {
#       vm_size = "Standard_B1s"
#       vm_count=1
#     }
#       prod = {
#       vm_size = "Standard_B1s"
#       vm_count=2
#     }
#   }
#   current_config = local.environment_config[terraform.workspace]
# }

# # Create a resource group
# resource "azurerm_resource_group" "main" {
#     name            =   "rg-${terraform.workspace}-${var.project_name}"
#     location        =   var.location
#     tags            =   {
#         environment =   terraform.workspace
#         project_name     =   var.project_name
#     }
# }

# # Create a virtual network
# resource "azurerm_virtual_network" "main" {
#     name            =   "vnet-${terraform.workspace}-${var.project_name}"
#     address_space   =   var.address_space
#     location= azurerm_resource_group.main.location
#   resource_group_name = azurerm_resource_group.main.name

#     # tags = {
#     #     managed_by  =   "terraform"
#     #     cost_center =   "engineering"
#     #     owner       =   "devops-team"
#     # }
#   depends_on = [ azurerm_resource_group.main ]
# }

# resource "azurerm_subnet" "main" {
#   name = "subnet-${terraform.workspace}-${var.project_name}"
#   resource_group_name = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes = var.subnet_address_prefixes
# depends_on = [ azurerm_virtual_network.main ,
# azurerm_resource_group.main]
# }

# resource "azurerm_network_interface" "main" {
#   count=local.current_config.vm_count
#   name="nic-${terraform.workspace}-${var.project_name}-${count.index+1}"
#   location= azurerm_resource_group.main.location
#   resource_group_name = azurerm_resource_group.main.name
#   ip_configuration {
#     name = "ipconfig-${terraform.workspace}-${var.project_name}-${count.index +1}"
#     subnet_id = azurerm_subnet.main.id 
#     private_ip_address_allocation = "Dynamic"
#   }
#   depends_on = [ azurerm_subnet.main ]
