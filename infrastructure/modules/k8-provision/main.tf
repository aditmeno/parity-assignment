resource "google_container_cluster" "new-k8-cluster" {
  name               = var.cluster_name
  location           = var.location
  initial_node_count = var.node_count
  project            = var.project

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  node_config {
    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      cluster = var.cluster_name
    }

    disk_size_gb = var.disk_size_gb
    machine_type = var.machine_type
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}