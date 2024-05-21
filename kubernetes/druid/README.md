# Overview

This directory will contain required artifacts to
install the Druid Operator for Kubernetes and the
artifacts to then install the Druid cluster using 
the operator.

# Install the Operator

We'll use Helm to install the operator based the 
[Getting Started Guid](https://github.com/druid-io/druid-operator/blob/master/docs/getting_started.md).

To install using helm:
1.  Edit the [values.yaml](./charts/operator/values.yaml) file
to your liking.
2. Execute the following:
```
helm upgrade -i cluster-druid-operator \
  -n druid-operator \
  --create-namespace \
  -f ./operator/chart/values.yaml
  ./operator/chart
```


# Install/Update the Cluster
```bash
kubectl apply -f cluster.yaml
```
