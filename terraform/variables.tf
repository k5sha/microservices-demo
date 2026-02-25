variable "environment" {
  type        = string
  description = "The environment where the terraform will apply"
}

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

variable "filepath_manifest" {
  type        = string
  description = "Path to Online Boutique's Kubernetes resources, written using Kustomize"
  default     = "../kustomize/"
}

variable "memorystore" {
  type        = bool
  description = "If true, Online Boutique's in-cluster Redis cache will be replaced with a AWS ElastiCache cache"
}

variable "node_min_size" {
  type        = number
  description = "Minimum number of worker nodes in the EKS node group. Used to set the lower bound for autoscaling."
  default     = 1
}

variable "node_max_size" {
  type        = number
  description = "Maximum number of worker nodes in the EKS node group. Defines the ceiling for horizontal scaling to prevent unexpected costs."
  default     = 3
}

variable "node_desired_size" {
  type        = number
  description = "The initial number of worker nodes the EKS node group should attempt to maintain upon deployment."
  default     = 1
}

variable "single_nat_gateway" {
  description = "Enable single NAT Gateway for all private subnets"
  type        = bool
  default     = true 
}