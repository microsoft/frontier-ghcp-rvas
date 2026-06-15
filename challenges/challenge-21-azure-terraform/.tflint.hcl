config {
  module = true
}

# The Azure ruleset gives reviewers naming and provider feedback without live
# Azure credentials. Decide in the workflow whether TFLint blocks merges or only
# informs plan reviewers.
plugin "azurerm" {
  enabled = true
  version = "0.27.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}
