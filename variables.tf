variable "location" {
  type    = string
  default = "West US 2"
}

# variable "resource_group_name" {
#   type = string
#    default = "rg-terraform-demo"
# }

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.0.0/28"]
}



variable "virtual_network_name" {
  type    = string
  default = "vnet-terraform-demo"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "team_name" {
  type        = string
  description = "name of team"
  default     = "devops-team"
}

variable "vm_count" {
  type    = number
  default = 1

}

variable "vm_size" {
  description = "size of VM"
  type        = string
  default     = "Standard_B1s"

}

variable "tags" {
  type    = map(string)
  default = {}

}

variable "db_name" {
  type        = string
  description = "database name"
  default     = "sqldbmed"
}


variable "server_name" {
  type        = string
  description = "sql server name"
  default     = "sqldbsrvmed"
}

variable "max_size_gb" {
  description = "size of DB"
  type        = number
  default     = 2
}

variable "sku_name" {
  type        = string
  description = "sku of mssql server"
  default     = "S0"
}


variable "msql_server_version" {
  description = "sql server version"
  type        = number
  default     = 12

}

variable "admin_login" {
  default     = "admin_user"
  description = "admin user name"
  type        = string
}


variable "admin_login_password" {
  default     = "ProjKpiSecure2024!#1341413"
  description = "admin login password"
  type        = string
  sensitive = true

}

variable "minimum_tls_version" {
  default     = "1.2"
  description = "tls version"
  type        = string
}

variable "app_service_sku" {
  description = "app service plan"
  type=string
  default = "B1"

}
