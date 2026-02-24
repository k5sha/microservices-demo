variable "name" {
  type        = string
  description = "Name given to the new EKS cluster"
  default     = "online-boutique"
}

variable "region" {
  type        = string
  description = "Region of the new EKS cluster"
  default     = "eu-central-1"
}

variable "namespace" {
  type        = string
  description = "Kubernetes Namespace in which the Online Boutique resources are to be deployed"
  default     = "staging"
}

variable "filepath_manifest" {
  type        = string
  description = "Path to Online Boutique's Kubernetes resources, written using Kustomize"
  default     = "../kustomize/"
}

variable "memorystore" {
  type        = bool
  description = "If true, Online Boutique's in-cluster Redis cache will be replaced with a AWS ElastiCache cache"
}
