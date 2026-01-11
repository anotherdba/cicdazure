
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

variable "db_name" {
  type=string
  description = "database name"
}


variable "server_name" {
  type=string
  description = "sql server name"
}

variable "max_size_gb" {
  description = "size of DB"
  type = number
  default  = 2
}

variable "sku_name" {
  type = string
  description = "sku of mssql server"
  default =  "Basic"
}
 

#  variable "msql_server_version" {
#   description = "sql server version"
#   type=string
#   default = "12.0"
   
#  }

 variable "admin_login" {
   default = "admin_user"
   description = "admin user name"
   type = string
 }  


 variable "admin_login_password" {
   default = "ProjKpiAdmin!2024Secure"
   description = "admin login password"
   type = string
   sensitive = true

 }

 variable "minimum_tls_version" {
   default = "1.2"
   description = "tls version"
   type = string
 }

variable "location" {
  description = "The azure region where resources will be created"
  type = string
  default = "west us 2"
}