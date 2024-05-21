```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm upgrade -i \
  --namespace druid \
  --create-namespace \
  -f values.yaml \
  zookeeper \
  bitnami/zookeeper
```
