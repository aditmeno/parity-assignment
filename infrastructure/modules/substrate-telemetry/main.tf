resource "kubernetes_horizontal_pod_autoscaler" "substrate-telemetry-app-scaler" {
  metadata {
    name = "${var.app_name}-scaler"
    namespace = var.namespace
  }
  spec {
    max_replicas = 5
    min_replicas = 1
    scale_target_ref {
      kind = "ReplicationController"
      name = "${var.app_name}-deployment"
    }
    target_cpu_utilization_percentage = 90
  }
}

resource "kubernetes_deployment" "substrate-telemetry-app-deploy" {
  metadata {
    name = "${var.app_name}-deployment"
    namespace = var.namespace
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          image = "${var.container_image}:latest"
          name  = "${var.app_name}-frontend"
          command = ["yarn", "start:frontend"]
          port { 
            name = "front-end-port"
            container_port = var.front_end_port
          }
        }
        container {
          image = "${var.container_image}:latest"
          name  = "${var.app_name}-backend"
          command = ["./telemetry"]
          port { 
            name = "telemetry-port"
            container_port = var.back_end_ports[0]
          }
          port { 
            name = "fd-sr-port"
            container_port = var.back_end_ports[1]
          }
          port { 
            name = "ws-tlmtry-port"
            container_port = var.back_end_ports[2]
          }
          env {
            name = "TELEMETRY_SERVER" 
            value = var.back_end_ports[0]
          }
          env {
            name = "FEED_SERVER" 
            value = var.back_end_ports[1]
          }
        }
      }
    }
  }
}