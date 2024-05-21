module "bootstrap_node_group" {
  source  = "cloudposse/eks-node-group/aws"
  version = "2.12.0"

  attributes        = ["bootstrap"]
  subnet_ids        = module.subnets.private_subnet_ids
  cluster_name      = module.eks_cluster.eks_cluster_id
  instance_types    = ["r6a.large"]
  desired_size      = 1
  min_size          = 1
  max_size          = 20
  kubernetes_labels = var.kubernetes_labels
  module_depends_on = module.eks_cluster.kubernetes_config_map_id

  block_device_map = {
    "/dev/xvda": {
      "ebs": {
        volume_size = 20
      }
    }
  }

  context = module.this.context
}
