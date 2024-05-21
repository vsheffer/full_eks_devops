# Overview

This set of Terraform files builds out a core EKS
cluster and manages the node groups.

# Bootstrap Node Group

Each new node group tries to create a role ARN with 
the same name and after the initial node group is created
additional node groups fail because the ARN already 
exists.  

The **bootstrap** node group should be the first node
group created and then the ARN can be referenced in 
subsequent node groups.

After the bootstrap node group is up you can add additional
Terraform files for different node groups with different
EC2 instances.

This should work as desired using the **module_depends_on**
Terraform property.
