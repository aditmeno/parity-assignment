variable "namespace" {
  description = "The namespace where app is created"
  type        = string
  default     = "parity"
}

variable "container_image" {
  description = "The container image used in the app"
  type        = string
  default     = "rezesius/substrate"
}

variable "user" {
  description = "The node name"
  type        = string
}

variable "port" {
  description = "The port on which node listens"
  type        = number
}

variable "ws_port" {
  description = "The websocket port on which node listens"
  type        = number
}

variable "rpc_port" {
  description = "The rpc port on which node listens"
  type        = number
}

variable "telemetry_url" {
  description = "The upstream monitoring app url"
  type        = string
}

variable "alice_url" {
  description = "The alice node ip"
  type        = string
  default     = "alice-svc.parity"
}

variable "alice_port" {
  description = "The alice node port"
  type        = string
  default     = "30333"
}