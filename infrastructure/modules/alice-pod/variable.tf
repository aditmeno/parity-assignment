variable "namespace" {
  description = "The namespace where app is created"
  type        = string
  default     = "default"
}

variable "container_image" {
  description = "The container image used in the app"
  type        = string
  default     = "rezesius/substrate"
}

variable "port" {
  description = "The port on which node listens"
  type        = number
  default     = 30333
}

variable "ws_port" {
  description = "The websocket port on which node listens"
  type        = number
  default     = 9944
}

variable "rpc_port" {
  description = "The rpc port on which node listens"
  type        = number
  default     = 9933
}

variable "telemetry_url" {
  description = "The upstream monitoring app url"
  type        = string
}