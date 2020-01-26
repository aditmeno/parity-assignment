output "lb_name" {
  value = kubernetes_service.k8-service.load_balancer_ingress[0].ip
}