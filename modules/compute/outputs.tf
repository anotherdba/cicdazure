output "resource_group_name" {
  description = "value"
  value = azurerm_resource_group.main.name
}

output "virtual_network_id" {
  description = "Id of virtual network"
  value = azurerm_virtual_network.main.id
  
}

output "vm_ids" {
  description = "list of IDs for virtual machine"
  value = azurerm_linux_virtual_machine.main[*].id
  
}