# Overview

This directory is used to install and manage the
Superset application.

# Add Helm Repos

I used stanard Helm repositories for the installtion.

To add the required ones execute the following:
```
helm repo add superset https://apache.github.io/superset
helm repo add postgres https://charts.bitnami.com/bitnami
helm repo add redis https://artifacthub.io/packages/helm/bitnami/redis 
```

# Install/Upgrade the Chart

To both install and upgrade the installation:
```
helm upgrade -i \
  --values values.yaml \
  superset \
  superset/superset
```

You can change the setup by modifying the contents of the **values.yaml**
file.

It is currently set up to expose the hostname **superset.803ventures.com**
with auto renewed TLS certificats using Letsencrypt.

The admin user particulars (feel free to change theses):
* Admin user: admin
* Admin password: 803VenturesSupersetAdminUserPassword

For now any alert related notifications for Superset will got to
vincent.sheffer@mac.com.

You can access the site at: https://superset.803ventures.com/ 
