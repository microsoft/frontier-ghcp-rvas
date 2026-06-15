terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id != "" ? var.subscription_id : null
}

resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
  numeric = true
}

resource "azurerm_resource_group" "workshop" {
  name     = "${var.name_prefix}-rg"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "platform" {
  name     = local.platform_resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "${local.storage_account_prefix}${random_string.suffix.result}st"
  resource_group_name      = azurerm_resource_group.workshop.name
  location                 = azurerm_resource_group.workshop.location
  account_tier             = "Standard"
  account_replication_type = var.storage_replication_type
  min_tls_version          = "TLS1_2"

  public_network_access_enabled   = var.enable_storage_public_network_access
  shared_access_key_enabled       = var.enable_storage_account_keys
  allow_nested_items_to_be_public = false
  tags                            = local.common_tags

  blob_properties {
    delete_retention_policy {
      days = var.blob_retention_days
    }

    container_delete_retention_policy {
      days = var.container_retention_days
    }
  }

  # TODO(workshop): Decide whether bootstrap should keep public network access
  # temporarily or require a private endpoint before switching this account into
  # the real backend.
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.tfstate_container_name
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

module "network" {
  source = "../../modules/network"

  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name
  address_space       = var.address_space
  subnet_prefixes     = var.subnet_prefixes
  tags                = local.common_tags
}

module "app" {
  source = "../../modules/app"

  resource_group_name            = azurerm_resource_group.platform.name
  location                       = azurerm_resource_group.platform.location
  log_analytics_workspace_name   = var.log_analytics_workspace_name
  log_retention_days             = var.log_retention_days
  container_app_environment_name = var.container_app_environment_name
  tags                           = local.common_tags
}