resource "kubernetes_namespace" "k8-namespace" {
  metadata {
    name = var.namespace_name
  }
}

