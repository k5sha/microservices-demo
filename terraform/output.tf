output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API Server"
  value       = module.eks.cluster_endpoint
}

output "cluster_region" {
  description = "AWS region"
  value       = var.region
}

output "vpc_id" {
  description = "VPC ID where the cluster is deployed"
  value       = module.vpc.vpc_id
}