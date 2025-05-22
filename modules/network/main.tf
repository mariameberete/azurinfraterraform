resource "azurerm_resource_group" "rg-terraformMariame" {
name = var.rg-resource_group
location = "France central"
}
resource "azurerm_virtual_network" "mariame_virtual" {
  name                = "mariame_virtual-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-terraformMariame.location
  resource_group_name = azurerm_resource_group.rg-terraformMariame.name
  tags ={ 
        env= "test"
        backup = "daily"
      }
}

resource "azurerm_subnet" "mariame_subnet" {
  name                 = "mariame_subnet-subnet"
  resource_group_name  = azurerm_resource_group.rg-terraformMariame.name
  virtual_network_name = azurerm_virtual_network.mariame_virtual.name
  address_prefixes     = ["10.0.1.0/24"]
}
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }
}
resource "azurerm_network_security_group" "acceptanceTestSecurityGroup1_mariame" {
  name                = "acceptanceTestSecurityGroup1_mariame"
  location            = azurerm_resource_group.rg-terraformMariame.location
  resource_group_name = azurerm_resource_group.rg-terraformMariame.name
}

resource "azurerm_network_security_rule" "acceptanceTestSecurityGroup1_rule_mariame" {
  for_each = toset(var.open_ports)
  name                        = "port-${each.key}"
  priority                    = 100+each.key
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = each.key
  destination_port_range      = each.key
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-terraformMariame.name
  network_security_group_name = azurerm_network_security_group.acceptanceTestSecurityGroup1_mariame.name
}
resource "azurerm_subnet_network_security_group_association" "security_group_association_mariame" {
  subnet_id                 = azurerm_subnet.mariame_subnet.id
  network_security_group_id = azurerm_network_security_group.acceptanceTestSecurityGroup1_mariame.id
}

