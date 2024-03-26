variable "name" {
  description = "Specifies the name of the Bastion Host."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Bastion Host."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "copy_paste_enabled" {
  description = "Copy/Paste feature enabled for the Bastion Host."
  type        = bool
  default     = true
}

variable "file_copy_enabled" {
  description = "Is File Copy feature enabled for the Bastion Host."
  type        = bool
  default     = false
}

variable "sku" {
  description = "The SKU of the Bastion Host. Accepted values are Basic and Standard."
  type        = string
  default     = "Basic"
}

variable "ip_connect_enabled" {
  description = "Is IP Connect feature enabled for the Bastion Host"
  type        = bool
  default     = false
}

variable "scale_units" {
  description = "The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50."
  type        = number
  default     = 2
}

variable "shareable_link_enabled" {
  description = "Is Shareable Link feature enabled for the Bastion Host."
  type        = bool
  default     = false
}

variable "tunneling_enabled" {
  description = " Is Tunneling feature enabled for the Bastion Host."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "ip_name" {
  description = "The name of the IP configuration."
  type        = string
}

variable "subnet_id" {
  description = "Reference to a subnet in which this Bastion Host has been created."
  type        = string
}

variable "public_ip_address_id" {
  description = "Reference to a Public IP Address to associate with this Bastion Host."
  type        = string
}
