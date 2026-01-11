locals {
  resource_suffix = "${var.environment}-${var.project_name}-compute"


  common_tags = merge (
    var.tags,
    {
      environment=var.environment
      team_name = var.team_name
      project_name = var.project_name
      managed_by = "terraform"
      module_name = "compute"
    }
  )
}



resource "azurerm_resource_group" "main" {
  name = "rg-${local.resource_suffix}"
  location = var.location
  tags = local.common_tags
}


resource "azurerm_virtual_network" "main" {
  name = "vnet-${local.resource_suffix}"
  address_space = var.address_space
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = local.common_tags

}

resource "azurerm_subnet" "main" {
  name = "subnet-${local.resource_suffix}"
  virtual_network_name = azurerm_virtual_network.main.name
   address_prefixes= var.subnet_address_prefixes
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_network_interface" "main" {
  count = var.vm_count
  name = "nic-${local.resource_suffix}-${count.index + 1}"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = local.common_tags
}


resource "azurerm_linux_virtual_machine" "main" {
  count=var.vm_count
  name                = "vm-${local.resource_suffix}-${count.index +1}"
   location= var.location
  resource_group_name = azurerm_resource_group.main.name
  size                = var.vm_size
  admin_username      = "adminuser"
  admin_password = "Passw0rd123#"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  depends_on = [ azurerm_resource_group.main ,
              azurerm_virtual_network.main]

 tags = local.common_tags
}