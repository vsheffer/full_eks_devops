region = "us-east-1"

availability_zones = ["us-east-1c", "us-east-1a", "us-east-1b"]

# I use this, typicall, to describe the project that the cluster
# is supporting.  In many cases you will only need be supporting
# a single project, though you may have different clusters for
# staging/test vs production (see the stage variable below)
namespace = "testing-terraform"

# Other good names for your "stage" are "production", "test",
# etc.
stage = "test"

# This one is up to you.
name = "eks"

# When updating the Kubernetes version, also update the API and client-go version in test/src/go.mod
kubernetes_version = "1.29"

oidc_provider_enabled = true

enabled_cluster_log_types = ["audit"]

cluster_log_retention_period = 7

kubernetes_labels = {}

cluster_encryption_config_enabled = true

# You may want to add additional EKS addons, but I have found
# these 2 to be a minimum for a production quality cluster.
addons = [
  {
    addon_name               = "vpc-cni"
    addon_version            = null
    resolve_conflicts        = "NONE"
    service_account_role_arn = null
  },
  {
    addon_name               = "aws-ebs-csi-driver"
    addon_version            = null
    resolve_conflicts        = "NONE"
    service_account_role_arn = null
  }
]
