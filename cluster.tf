#AKS resource here
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                       = "k8s-secureaks-demo-weu"
  location                   = data.azurerm_resource_group.aks_rg.location
  resource_group_name        = data.azurerm_resource_group.aks_rg.name
  dns_prefix_private_cluster = "secureaks"
  private_cluster_enabled    = true
  private_dns_zone_id        = azurerm_private_dns_zone.aks_dns.id
  sku_tier                   = "Standard"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  default_node_pool {
    name           = "default"
    node_count     = 2
    vm_size        = "Standard_B2s"
    vnet_subnet_id = azurerm_subnet.nodes_snet.id
  }

  depends_on = [
    azurerm_role_assignment.network_contributor,
    azurerm_role_assignment.dns_contributor
  ]
}

resource "local_file" "demo_values" {
  content = templatefile("${path.module}/values.tftpl", {

  })
  filename = "${path.module}/helmchart/secureaks-demo-helmchart/values.yaml"
}

resource "helm_release" "demo" {
  name             = "secureaks-demo-helmchart"
  chart            = "./helmchart/ollama-demo-helmchart"
  namespace        = "secureaks"
  create_namespace = true
  wait             = true

  depends_on = [
    local_file.demo_values
  ]
}