resource "kubernetes_service" "k8-service" {
  metadata {
    name = var.service_name
    namespace = var.namespace
  }
  spec {
    selector = {
      app = var.app_name
    }
    port {
      name        = "front-end-port"
      port        = var.ports[0]
      target_port = var.ports[0]
    }
    port {
      name        = "back-end-port"
      port        = var.ports[1]
      target_port = var.ports[1]
    }
    type = "LoadBalancer"
  }
}