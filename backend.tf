terraform {
  backend "azurerm" {
    resource_group_name  = "rg-mariamestorageaccount"
    storage_account_name = "storageaccountmariame1"
    container_name       = "tfstates"
    key                  = "terraform.tfstate"
  }
}