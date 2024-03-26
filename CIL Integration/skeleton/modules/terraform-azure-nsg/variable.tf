
#---------------------Network Security Group---------------------#

variable "csv_file_name_for_NSG" {
  description = "Name of the CSV file where Network Security Rule details defined."
  type        = string 
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string  
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the network security group. Changing this forces a new resource to be created."
  type        = string 
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string) 
}
