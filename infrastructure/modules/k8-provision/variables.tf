variable "cluster_name" {
  description = "The name for the k8 cluster"
  type        = string
}

variable "project" {
  description = "The name for the gcp project"
  type        = string
}

variable "location" {
  description = "The cluster region"
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the node pool"
  type        = number
}

variable "disk_size_gb" {
  description = "The disk space allocated to the nodes"
  type        = number
  default     = 10
}

variable "machine_type" {
  description = "The spec for the nodes"
  type        = string
  default     = "g1-small"
}