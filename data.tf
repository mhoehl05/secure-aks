data "azurerm_resource_group" "aks_rg" {
  name = "rg-secureaks-demo-weu"
}

data "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub-demo-weu"
  resource_group_name = "rg-hubnetwork-demo-weu"
}