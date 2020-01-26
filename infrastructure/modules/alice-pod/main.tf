resource "kubernetes_service" "alice-svc" {
  metadata {
    name = "alice-svc"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "${kubernetes_deployment.alice-deploy.metadata.0.labels.app}"
    }
    port {
      name        = "p2p-port"
      port        = var.port
      target_port = var.port
    }
    port {
      name        = "ws-port"
      port        = var.ws_port
      target_port = var.ws_port
    }
    port {
      name        = "rpc-port"
      port        = var.rpc_port
      target_port = var.rpc_port
    }
  }
}

resource "kubernetes_deployment" "alice-deploy" {
  metadata {
    name = "alice-deploy"
    namespace = var.namespace
    labels = {
      app = "alice"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "alice"
      }
    }

    template {
      metadata {
        labels = {
          app = "alice"
        }
      }

      spec {
        container {
          image = "${var.container_image}:latest"
          name  = "alice-node"
          command = ["./entrypoint.sh"]
          port { 
            name = "port"
            container_port = var.port
          }
          port { 
            name = "ws-port"
            container_port = var.ws_port
          }
          port { 
            name = "rpc-port"
            container_port = var.rpc_port
          }
          env {
            name = "USER" 
            value = "alice"
          }
          env {
            name = "PORT" 
            value = var.port
          }
          env {
            name = "WS_PORT" 
            value = var.ws_port
          }
          env {
            name = "RPC_PORT" 
            value = var.rpc_port
          }
          env {
            name = "TELEMETRY_URL" 
            value = var.telemetry_url
          }
        }
      }
    }
  }
}
