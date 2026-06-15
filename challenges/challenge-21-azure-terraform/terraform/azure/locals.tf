locals {
  sanitized_name_prefix        = replace(lower(var.name_prefix), "-", "")
  storage_account_prefix       = substr(local.sanitized_name_prefix, 0, 13)
  platform_resource_group_name = var.resource_group_name != "" ? var.resource_group_name : "${var.name_prefix}-${var.environment}-platform-rg"

  common_tags = merge({
    environment = var.environment
    managed_by  = "terraform"
    workload    = "azure-terraform-workshop"
  }, var.tags)
}