terraform {
  required_version = ">= 1.5.7"
  backend "azurerm" {
    resource_group_name  = "thomasthorntoncloud"
    storage_account_name = "thomasthorntontfstate"
    container_name       = "github-thomasthorntoncloud-terraform-example"
    key                  = "github-thomasthorntoncloud-terraform-example.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "tamops" {
  name     = "github-thomasthorntoncloud-terraform-example"
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
  