terraform {
  required_version = ">= 1.5.7"
  backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "jamiemcconnell2801"
    container_name       = "tfstatedevops"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "tamops" {
  name     = "tamopstfstates"
  location = "uksouth"
}

#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "tamops-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.tamops.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.tamops.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.0.0/24"]
}
