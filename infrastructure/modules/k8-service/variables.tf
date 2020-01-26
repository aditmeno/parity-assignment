variable "service_name" {
  description = "The name for the k8 service"
  type        = string
}

variable "namespace" {
  description = "The namespace where service is created"
  type        = string
}

variable "app_name" {
  description = "The name for the k8 app the service targets"
  type        = string
}

variable "ports" {
  description = "The ports service exposes"
  type        = list(number)
}
