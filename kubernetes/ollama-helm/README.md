# Overview

Simple Helm chart to deploy ollama with codellama model.

The model is stored in a PV which is created by running

```
kubectl -n <your namespace> -f pvc-models.yaml
```

from this directory.
