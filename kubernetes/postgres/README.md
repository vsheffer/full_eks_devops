First create PVC:
```
kubectl apply -f pvc.yaml -n db
```

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade -i \
  postgresql \
  -n db \
  --create-namespace \
  --values values.yaml \
  bitnamni/postgresql 
```
