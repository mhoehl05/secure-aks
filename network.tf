resource "azurerm_virtual_network" "aks_vnet" {
  name                = "vnet-secureaks-demo-weu"
  location            = data.azurerm_resource_group.aks_rg.location
  resource_group_name = data.azurerm_resource_group.aks_rg.name
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "nodes_snet" {
  name                 = "AksNodesSubnet"
  resource_group_name  = data.azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.2.0.0/23"]
}