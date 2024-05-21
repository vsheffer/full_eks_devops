# Overview
A very brief intrl to cert-manager is that it manages the creation of valid
TLS certificates based on annotations in the **ingress** definitions for 
Kubernetes services.  We use a service called Let's Encrypt to generate the
certs.

This doc provides the instructions for installing the **cert-manager** into 
the bluemvmmt cluster.

## Install the cert-manager controller
First step is to install the cert-manager controller that is general for all
certificate providers.  Cert-manager requires Kubernetes Custom Resource Definitions
which can be deployed in multiple ways.  We have chose to use the Helm chart for 
that.
```
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager \
  jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  -f values.yaml
```
## Install the ClusterIssuer 
Once **cert-manager** is installed we have to define certificate issuers separately.  
We will, for now, just install a **ClusterIssuer** to support the entire cluster.
```bash
kubectl apply -f cluster-issuer-prod
```

