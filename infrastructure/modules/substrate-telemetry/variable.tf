variable "app_name" {
  description = "The name for the k8 app the service targets"
  type        = string
}

variable "namespace" {
  description = "The namespace where app is created"
  type        = string
}

variable "container_image" {
  description = "The continaer image to use with pod"
  type        = string
}

variable "front_end_port" {
  description = "The port on which front end listner uses"
  type        = number
}

variable "back_end_ports" {
  description = "The ports on which back end listner uses"
  type        = list(number)
}
