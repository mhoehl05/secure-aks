resource "azurerm_private_dns_zone" "aks_dns" {
  name                = "privatelink.westeurope.azmk8s.io"
  resource_group_name = data.azurerm_resource_group.aks_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_aks_link" {
  name                  = "dnslink-secureaks-demo-weu"
  resource_group_name   = data.azurerm_resource_group.aks_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns.name
  virtual_network_id    = azurerm_virtual_network.aks_vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_hub_link" {
  name                  = "dnslink-hub-demo-weu"
  resource_group_name   = data.azurerm_resource_group.aks_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns.name
  virtual_network_id    = data.azurerm_virtual_network.hub_vnet.id
}