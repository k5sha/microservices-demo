module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  # For saving money (for prod set to false)
  single_nat_gateway = true

  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.name
  cluster_version = "1.32"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    general = {
      min_size     = 3
      max_size     = 6
      desired_size = 4
      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
    }
  }
}

resource "aws_eks_access_policy_association" "admin_policy" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::718286622836:user/terraform-user"

  access_scope {
    type = "cluster"
  }
}
