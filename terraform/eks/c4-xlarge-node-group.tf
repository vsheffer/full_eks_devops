module "c4-xlarge-node-group" {
  source  = "cloudposse/eks-node-group/aws"
  version = "2.12.0"

  attributes        = ["c4-xlarge"]
  subnet_ids        = module.subnets.private_subnet_ids
  cluster_name      = module.eks_cluster.eks_cluster_id
  cluster_autoscaler_enabled = true
  instance_types    = ["c4.xlarge"]
  desired_size      = 2
  min_size          = 2
  max_size          = 20
  kubernetes_labels = var.kubernetes_labels
  node_role_arn     = [module.bootstrap_node_group.eks_node_group_role_arn]
  module_depends_on = module.bootstrap_node_group
  context = module.this.context
}
