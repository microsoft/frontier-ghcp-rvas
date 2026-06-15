output "resource_group_name" {
  description = "Resource group created for Terraform state bootstrap resources."
  value       = azurerm_resource_group.workshop.name
}

output "platform_resource_group_name" {
  description = "Resource group created for platform resources."
  value       = azurerm_resource_group.platform.name
}

output "storage_account_name" {
  description = "Storage account that can hold Terraform state or workshop assets."
  value       = azurerm_storage_account.tfstate.name
}

output "tfstate_container_name" {
  description = "Private blob container provisioned for Terraform state."
  value       = azurerm_storage_container.tfstate.name
}

output "tfstate_public_network_access_enabled" {
  description = "Whether the Terraform state storage account currently allows public network access. Review this before using it for shared state."
  value       = azurerm_storage_account.tfstate.public_network_access_enabled
}

output "tfstate_shared_access_key_enabled" {
  description = "Whether storage account keys remain enabled for the Terraform state account."
  value       = azurerm_storage_account.tfstate.shared_access_key_enabled
}

output "subnet_id" {
  description = "Application subnet ID."
  value       = module.network.subnet_id
}

output "container_app_environment_id" {
  description = "Azure Container Apps environment ID."
  value       = module.app.container_app_environment_id
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID."
  value       = module.app.log_analytics_workspace_id
}

output "azure_login_hint" {
  description = "Command to run before planning if you have not authenticated with Azure CLI yet."
  value       = "az login"
}