# Introduction

This directory contains the specifications to 
manage a Kafka cluster.

To change the number of nodes, resource requirements,
etc. update the **values.yaml** file.

To apply the changes execute:

```
helm upgrade -i \
   -n kafka \
   --create-namespace \
   --values values.yaml \
   kafka \
   bitnami/kafka
```

Sometimes you may need to supply the cluster ID, which is
secret when you update the cluster.  When that is the case
you will need to provide that as a value when you upgrade.  
In this case, the KRAFT_CLUSTER_ID is a secret.  

To get the current value:
```bash
export KRAFT_CLUSTER_ID=$(kubectl get secret --namespace kafka kafka-kraft-cluster-id -o jsonpath="{.data.kraft-cluster-id}" | base64 -d)
```

Then to upgrade the chart:
```bash
helm upgrade \
  -n kafka \
  --set kraft.clusterId=$KRAFT_CLUSTER_ID \
  -f values.yaml \
  kafka bitnami/kafka
```
