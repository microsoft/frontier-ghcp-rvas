variable "resource_group_name" {
  type        = string
  description = "Resource group for the application resources."

  validation {
    condition     = length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 90
    error_message = "resource_group_name must be 1-90 characters."
  }
}

variable "location" {
  type        = string
  description = "Azure region for the application resources."
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Log Analytics workspace name."

  validation {
    condition     = can(regex("^[A-Za-z0-9-]{4,63}$", var.log_analytics_workspace_name))
    error_message = "log_analytics_workspace_name must be 4-63 characters and use only letters, numbers, and hyphens."
  }
}

variable "log_retention_days" {
  type        = number
  description = "Log Analytics retention in days."

  validation {
    condition     = contains([30, 60, 90], var.log_retention_days)
    error_message = "log_retention_days must be 30, 60, or 90."
  }
}

variable "container_app_environment_name" {
  type        = string
  description = "Azure Container Apps environment name."

  validation {
    condition     = startswith(var.container_app_environment_name, "cae-") && length(var.container_app_environment_name) <= 32
    error_message = "container_app_environment_name must start with cae- and be 32 characters or fewer."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to application resources."

  validation {
    condition     = alltrue([for key in ["owner", "cost_center", "data_classification", "environment", "managed_by"] : contains(keys(var.tags), key)])
    error_message = "tags must include owner, cost_center, data_classification, environment, and managed_by."
  }
}
