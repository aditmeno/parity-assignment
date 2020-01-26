resource "kubernetes_deployment" "substrate-deploy" {
  metadata {
    name = "${var.user}-deploy"
    namespace = var.namespace
    labels = {
      app = var.user
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.user
      }
    }

    template {
      metadata {
        labels = {
          app = var.user
        }
      }

      spec {
        container {
          image = "${var.container_image}:latest"
          name  = "${var.user}"
          command = ["./entrypoint.sh]
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
            name = "ALICE_IP" 
            value = var.alice_url
          }
          env {
            name = "ALICE_PORT" 
            value = var.alice_port
          }
          env {
            name = "USER" 
            value = var.user
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