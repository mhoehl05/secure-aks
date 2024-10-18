resource "azurerm_virtual_network_peering" "hub" {
  name                      = "peerhubtoaks"
  resource_group_name       = data.azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.aks_vnet.id
}

resource "azurerm_virtual_network_peering" "aks" {
  name                      = "peerakstohub"
  resource_group_name       = data.azurerm_resource_group.aks_rg.name
  virtual_network_name      = azurerm_virtual_network.aks_vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.hub_vnet.id
}