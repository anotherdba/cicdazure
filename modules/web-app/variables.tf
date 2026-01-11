
variable "project_name" {
  description = " project name"
  type = string
}



variable "tags" {
  description = "Tags to apply to the resources"
  type = map(string)
}

variable "environment" {
  description = "environment for "
  type= string
  validation {
    condition = contains(["dev","staging","prod"], lower(var.environment))
    error_message = "environment must be one fo the following: dev, staging, prod"
  }
  
}

variable "app_service_sku" {
  description = "app service plan"
  type=string
  default = "F1"  
}

variable "database_connection_string" {
  description = "db connection string"
  type=string
  sensitive = true
  default = "value"
}







  






variable "location" {
  description = "The azure region where resources will be created"
  type = string
  default = "west us 2"
}