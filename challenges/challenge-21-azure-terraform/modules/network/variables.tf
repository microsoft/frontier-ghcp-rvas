variable "resource_group_name" {
  type        = string
  description = "Resource group for the network resources."

  validation {
    condition     = length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 90
    error_message = "resource_group_name must be 1-90 characters."
  }
}

variable "location" {
  type        = string
  description = "Azure region for the network resources."
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name."

  validation {
    condition     = startswith(var.vnet_name, "vnet-") && length(var.vnet_name) <= 64
    error_message = "vnet_name must start with vnet- and be 64 characters or fewer."
  }
}

variable "subnet_name" {
  type        = string
  description = "Subnet name for the application tier."

  validation {
    condition     = startswith(var.subnet_name, "snet-") && length(var.subnet_name) <= 80
    error_message = "subnet_name must start with snet- and be 80 characters or fewer."
  }
}

variable "address_space" {
  type        = list(string)
  description = "Address space assigned to the virtual network."

  validation {
    condition     = length(var.address_space) > 0 && alltrue([for cidr in var.address_space : can(cidrhost(cidr, 0))])
    error_message = "address_space must contain at least one valid CIDR block."
  }
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "Address prefixes assigned to the subnet."

  validation {
    condition     = length(var.subnet_prefixes) > 0 && alltrue([for cidr in var.subnet_prefixes : can(cidrhost(cidr, 0))])
    error_message = "subnet_prefixes must contain at least one valid CIDR block."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the virtual network."

  validation {
    condition     = alltrue([for key in ["owner", "cost_center", "data_classification", "environment", "managed_by"] : contains(keys(var.tags), key)])
    error_message = "tags must include owner, cost_center, data_classification, environment, and managed_by."
  }
}
