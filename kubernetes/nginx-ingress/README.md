# Overview

This directory is dedicated to installing Nginx Ingress
into the cluster.

It uses the Nginx Helm chart to deploy.  The only file
here is a Helm varfile to set the many parameters the 
Helm chart supports and that are relevant to the deploytment.

## Installation

The simplest way to install the controller is to issue the
following command:

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade -i ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  -f values.yaml \
  ingress-nginx/ingress-nginx
```
