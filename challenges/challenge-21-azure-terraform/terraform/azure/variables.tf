variable "subscription_id" {
  description = "Azure subscription ID. Leave empty to use the active Azure CLI context."
  type        = string
  default     = ""

  validation {
    condition     = var.subscription_id == "" || can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.subscription_id))
    error_message = "subscription_id must be empty or a valid Azure subscription GUID."
  }
}

variable "location" {
  description = "Azure region for the workshop resources."
  type        = string
  default     = "eastus2"

  validation {
    condition = contains([
      "centralus",
      "eastus",
      "eastus2",
      "northeurope",
      "westus3",
      "westeurope"
    ], var.location)
    error_message = "location must be one of the approved workshop Azure regions. Update the allow-list only after documenting the region decision."
  }
}

variable "name_prefix" {
  description = "Short prefix used when naming Azure resources."
  type        = string
  default     = "tfworkshop"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,11}[a-z0-9]$", var.name_prefix))
    error_message = "name_prefix must be 3-13 characters, lowercase, start with a letter, end with a letter or number, and use only letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Environment tag applied to all resources."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be dev, test, or prod."
  }
}

variable "resource_group_name" {
  description = "Optional resource group name for platform resources. Leave empty to derive it from name_prefix and environment."
  type        = string
  default     = ""

  validation {
    condition     = var.resource_group_name == "" || (length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 90)
    error_message = "resource_group_name must be empty or 1-90 characters."
  }
}

variable "vnet_name" {
  description = "Virtual network name for the platform network."
  type        = string
  default     = "vnet-platform-dev"

  validation {
    condition     = startswith(var.vnet_name, "vnet-") && length(var.vnet_name) <= 64
    error_message = "vnet_name must start with vnet- and be 64 characters or fewer."
  }
}

variable "subnet_name" {
  description = "Subnet name for the application platform."
  type        = string
  default     = "snet-app"

  validation {
    condition     = startswith(var.subnet_name, "snet-") && length(var.subnet_name) <= 80
    error_message = "subnet_name must start with snet- and be 80 characters or fewer."
  }
}

variable "address_space" {
  description = "Address space assigned to the virtual network."
  type        = list(string)
  default     = ["10.24.0.0/16"]

  validation {
    condition     = length(var.address_space) > 0 && alltrue([for cidr in var.address_space : can(cidrhost(cidr, 0))])
    error_message = "address_space must contain at least one valid CIDR block."
  }
}

variable "subnet_prefixes" {
  description = "Address prefixes assigned to the application subnet."
  type        = list(string)
  default     = ["10.24.1.0/24"]

  validation {
    condition     = length(var.subnet_prefixes) > 0 && alltrue([for cidr in var.subnet_prefixes : can(cidrhost(cidr, 0))])
    error_message = "subnet_prefixes must contain at least one valid CIDR block."
  }
}

variable "log_analytics_workspace_name" {
  description = "Log Analytics workspace name used by the Container Apps environment."
  type        = string
  default     = "log-platform-dev"

  validation {
    condition     = can(regex("^[A-Za-z0-9-]{4,63}$", var.log_analytics_workspace_name))
    error_message = "log_analytics_workspace_name must be 4-63 characters and use only letters, numbers, and hyphens."
  }
}

variable "container_app_environment_name" {
  description = "Azure Container Apps environment name."
  type        = string
  default     = "cae-platform-dev"

  validation {
    condition     = startswith(var.container_app_environment_name, "cae-") && length(var.container_app_environment_name) <= 32
    error_message = "container_app_environment_name must start with cae- and be 32 characters or fewer."
  }
}

variable "tfstate_container_name" {
  description = "Blob container name for Terraform state storage."
  type        = string
  default     = "tfstate"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.tfstate_container_name))
    error_message = "tfstate_container_name must be 3-63 lowercase characters, start and end with a letter or number, and use only letters, numbers, and hyphens."
  }
}

variable "storage_replication_type" {
  description = "Replication type for the Terraform state storage account. Choose the smallest option that meets the environment recovery requirement."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "ZRS"], var.storage_replication_type)
    error_message = "storage_replication_type must be LRS or ZRS for this workshop. Document any broader redundancy requirement before expanding the list."
  }
}

variable "enable_storage_public_network_access" {
  description = "Whether the Terraform state storage account allows public network access. Leave the final decision documented in docs/platform-notes.md."
  type        = bool
  default     = true
}

variable "enable_storage_account_keys" {
  description = "Whether storage account keys remain enabled for the Terraform state account. Disable only after the backend authentication path is ready."
  type        = bool
  default     = true
}

variable "blob_retention_days" {
  description = "Soft delete retention in days for state blobs."
  type        = number
  default     = 14

  validation {
    condition     = var.blob_retention_days >= 7 && var.blob_retention_days <= 90
    error_message = "blob_retention_days must be between 7 and 90 days."
  }
}

variable "container_retention_days" {
  description = "Soft delete retention in days for deleted state containers."
  type        = number
  default     = 14

  validation {
    condition     = var.container_retention_days >= 7 && var.container_retention_days <= 90
    error_message = "container_retention_days must be between 7 and 90 days."
  }
}

variable "log_retention_days" {
  description = "Log Analytics retention in days for platform diagnostics."
  type        = number
  default     = 30

  validation {
    condition     = contains([30, 60, 90], var.log_retention_days)
    error_message = "log_retention_days must be 30, 60, or 90 for the workshop environments."
  }
}

variable "tags" {
  description = "Extra Azure tags merged into the default workshop tag set."
  type        = map(string)
  default = {
    owner               = "platform-team"
    cost_center         = "hackathon"
    data_classification = "internal"
  }

  validation {
    condition = alltrue([
      for key in ["owner", "cost_center", "data_classification"] : contains(keys(var.tags), key) && trimspace(var.tags[key]) != ""
    ])
    error_message = "tags must include non-empty owner, cost_center, and data_classification values."
  }

  validation {
    condition     = contains(["public", "internal", "confidential"], lookup(var.tags, "data_classification", ""))
    error_message = "tags.data_classification must be public, internal, or confidential."
  }
}