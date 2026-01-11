variable "project_name" {
  description = " project name"
  type = string
}

variable "team_name" {
  description = "name of the team"
  type = string
  
}

variable "environment" {
  description = "environment for "
  type= string
  validation {
    condition = contains(["dev","staging","prod"], lower(var.environment))
    error_message = "environment must be one fo the following: dev, staging, prod"
  }
  
}

variable "location" {
  description = "The azure region where resources will be created"
  type = string
  default = "west us 2"
}

variable "vm_count" {
 description = "The number of virtual machines"
 type= number 
 default = 1

 validation {
   condition = var.vm_count >= 1 && var.vm_count <=5
   error_message = "the vm_count must be positive integer from 1 to 5"
 }
}

variable "vm_size" {
  description = "size of the VM"
  type=string
  default = "Standard_B1s"
}

variable "subnet_address_prefixes" {
  description = "the address of prefixes for the subnet"
  type = list(string)
  
}

variable "tags" {
  description = "Tags to apply to the resources"
  type = map(string)
}

variable "address_space" {
  description = "address space of vnet"
  type= list(string)
}