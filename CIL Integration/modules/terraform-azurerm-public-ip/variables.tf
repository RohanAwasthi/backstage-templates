
variable "location" {
  description = "(Required) Location of the public IP to be created"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Resource group of the public IP to be created"
  type        = string
}

variable "public_ip_name" {
  description = "(Required) Name of the public IP to be created"
  type        = string
}

variable "allocation_method" {
  description = "(Required) Defines the allocation method for this IP addres"
  type        = string
  default = "Static"
}

variable "sku" {
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default     = "Standard"
}

variable "ip_version" {
  description = "(Optional) The IP Version to use, IPv6 or IPv4."
  type        = string
  default     = "IPv4"
}

variable "idle_timeout_in_minutes" {
  description = "(Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = null
}

variable "domain_name_label" {
  description = "(Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  type        = string
  default     = null
  
}

variable "generate_domain_name_label" {
  description = "Generate automatically the domain name label, if set to true, automatically generate a domain name label with the name"
  type        = bool
  default     = false
}

variable "reverse_fqdn" {
  description = "(Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for the resource to be deployed."
  type        = map(any)
}

variable "zones" {
  description = "(Optional) The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. Defaults to Zone-Redundant."
  type        = list(string)
  default = []
  # default     = ["Zone-Redundant"]
}

variable "ddos_protection_mode" {
  description = "(Optional) The DDoS protection mode. Defaults to Standard. Possible values are Basic and Standard."
  type        = string
  default     = "Disabled"
}

variable "ddos_protection_plan_id" {
  description = "(Optional) The ID of a DDoS protection plan resource to associate with the Public IP. Only set this when the ddos_protection_mode is set to Standard."
  type        = string
  default     = null
}

variable "ip_tags" {
  description = "A mapping of IP tags to assign to the public IP."
  type        = map(any)
  default = {
    environment = "Production"
  
  }
}

variable "public_ip_prefix_id" {
  description = "(Optional) If specified then public IP address allocated will be provided from the public IP prefix resource." 
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "(optional)The SKU Tier that should be used for the Public IP."
  type        = string
  default     = "Regional"
}

variable "edge_zone" {
  description = "(optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist."
  type        = string
  default     = null
}
