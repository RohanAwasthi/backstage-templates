
#---------------------------------------- resource group variables -----------------------------------------
variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  type        = bool
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "The location/region to keep all your resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(any)
}
