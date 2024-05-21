# Overview

This installs a Kubernetes addon that syncs secrets
across namespaces.

# Installation

```bash
helm repo add emberstack https://emberstack.github.io/helm-charts
helm repo update
helm upgrade --install reflector -n kube-system emberstack/reflector
```

The defaults are all fine for this chart.
