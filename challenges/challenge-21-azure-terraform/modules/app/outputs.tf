output "container_app_environment_id" {
  description = "Azure Container Apps environment ID."
  value       = azurerm_container_app_environment.this.id
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID."
  value       = azurerm_log_analytics_workspace.this.id
}
