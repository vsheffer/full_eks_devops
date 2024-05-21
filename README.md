# Overview

I've worked with Kubernetes for over 10 years now and have
found it hard to find a source that puts all of the tools
in one place to get started with using this very powerful
framework.

The purpose of this repository is most definitely not to 
be a definitive guide to all things Kubernetes, not even
in a specific AWS EKS setting.

The purpose of this repository _is_ to provide a complete
solution to stand up a production quality EKS Kubernetes
cluster and all of the tools to manage it in literally 
minutes.

Assuming you have an AWS account that is absolutely 
true.  Now, of course, Kubernetes, being an operating
system for massive compute clusters, moving beyond just
standing up the cluster and managing it isn't that simple,
and is left as an exercise for the reader.

The intent of this is to put all of the tools in place
to make it as simple and quick as possible all in one
place to literally stand up an EKS cluster in minutes.

## Deployment Management Tools

This project uses several tools:

 * Terraform - provision the EKS cluster
 * Helm - to manage most of Kubernetes installs
 * kubectl - for basic Kubernetes management
 * aws cli 

To support the above there is a 

[Vagrantfile](Vagrantfile) that
provisions all of the tools for easy access.

All you need to do is create an .aws directory that 
matches your $HOME/.aws directory when you install
these tools in your host.

## CloudPosse EKS Provisioning

This project relies heavily on CloudPosse Terraform
modules to provision the EKS cluster and VPC networking,
as well as many other AWS resources to make accessing and
managing your EKS cluster easy.

There are a few other important services required to 
have a fully production ready EKS cluster.

 * cert-manager
 * AWS NLB with Nginx Ingress

This repo provides infrastructure as code and instructions
to quickly provision your EKS cluser and these other 
services in one place.

# How-to 

This is entirely AWS EKS centric so all of the how-to instuctions
only apply to AWS.  This assumes you have an AWS account and
necessary permissions and associated credentials to provision all 
of the required resources.

## Step 0 - Prerequisites

From your local computer you only need to [install Vagrant](https://developer.hashicorp.com/vagrant/docs/installation).  Vagrant
is a Virtual Machine management tool, and it relies on your computer
having a Virtual Machine management tool which varies from operating
system to the next.

I have long used VirtualBox, which runs on Mac, Windows and Linux.  
Windows and Linux both have other options if you don't want to use
VirtubalBox.

This is one of many left for the reader exercises.

## Step 1 - Start up Vagrant box

After cloning this repo you need to copy your $HOME/.aws/ directory
to this directory (specifically .aws).  There are a lot of ways
to get the contents of the directory and this project leaves that
as an exercise to the user.

But, after you have your .aws directory setup, just

```
# The following is definitetely required on Mac hosts because the
# VM guest won't time sync without and that interferes with AWS CLI
# authentication.  
#
# Not sure if this works on Windows or if it is even needed, but time
# sycning is essential to interacting with AWS CLI.

vagrant plugin install vagrant-vbguest 
vagrant up
vagrant ssh
```

The latter will get you into the box.  The contents of all of the other 
files in this repo will now be in /vagrant.

Note that you can use **git** within that directory when  you
need to modify any of the specifics for your EKS cluster.

**NOTE:** forking the repo may be the best way to, say, support
multiple environments with different configurations.

## Step 2 - Set up S3 Bucket for Terraform State

Terraform is basically a (static) state machine that takes 
your desired AWS resource state and then ensures that your
desired state becomes the actual state.  **Static** is the
key word here which differentiates it from Kubernetes, which
performs a very similar set of tasks but does do dynamically
(that is a story for another time).

But the bottom line is that state needs to be stored somewhere.

This repo is agnostic on that, but the example
**backend.tf** assumes an S3 bucket will store the state.

So, you need to create an S3 bucket to store the state and
update [backend.tf](terraform/eks/backend.tf) appropriately.  This is one of many
exercises left to the reader.

## Step 3 - Configure your EKS Cluster

Most everything that you'll want to modify is in the [fixtures.tfvars](terraform/eks/fixtures.tfvars)
file.  The variables are mostly self explanatory.

The imporant point about that file is that you can use it to support
multiple EKS clusters for various environments/regions.  My recommendation
is to have one for, say, test/staging/production.  The CloudPosse 
terraform modules that I'm using here for each cluster is *not* 
multi-regional.  But, they are multi availability zones so, for 
most use cases, you'll get all of the fault tolerance you'll ever need. 

## Step 4 - Provision Your Cluster

Now that all of the ducks are in a row there are just a couple of simple
steps to provision a complete EKS cluster and all of its other stuff
required to have a fully operational, production quality EKS cluster.

Here they are (assuming you are in the Vagrant box):

```
cd /vagrant/terraform/eks
terraform init
terraform apply -var-file fixtures.tfvar
```

This is very simplistic, but this will do for now.  If you are new
to Terraform you'll see a *lot* of stuff that is about to provision
for you.  You'll be asked if you want to proceed.  If you've made it
 this are I'd say just answer **yes**.

The cool thing about Terraform is that you can, if you aren't happy,
issue the following command:

```
terraform destroy -var-file fixtures.tfvars
```

And you can start over.

Assuming you haven't started over you'll wait...many minutes while
Terraform does its thing.  Once it is finished...


## Step 5 - Access our Kubernetes Cluster

CloudPosse does all of the heavy lifting you need (and believe me,
it is heavy lifting) to make it easy to start accessing your 
Kubernetes cluster in a secure way using the `kubectl` CLI tool
that is already installed in your Vagrant box.

```
aws eks update-kubeconfig --region us-east-1 --name <namespace>-<stage>-<name>-cluster
```
The <namespace>, <stage>, and <name> come from you fixtures.tfvars file.

After issuing that command you can then execute all of `kubectl` commands.

# Running Shells

It is often useful to run a shell inside the cluster and the easiest way to
do that is the `kubectl run` command.  But, before you can use **kubectl** you have to create a .kubeconfig file.  you can do that with the following command:

Here is an example running a shell with the **psql** client installed so you
can access a **PostgreSQL** database:

```
kubectl run \
   pg-shell \
   -i --tty --rm \
   --image postgres \
   --env="PGUSER=postgres" \
   --env="PGPASSWORD=<password>" \
   --env="PGHOST=<pghost>" \
   -- bash
```
Once in you can run `psql` and you'll be connected to the server.  Obviously 
you don't have to provide the usernaem/password/host in environment variables
and add them to the `psql` command line.

If you just neeed a shell this should work:
```
kubectl run \
  ubuntu-shell \
  -i --tty --rm \
  --image ubuntu:22 \
  -- bash
```
[ MORE TO COME TO INSTALL THE REST ] 
