# CFL Summit | Rancher Lab

## What are we working with?

In the lab we'll start out with:
- RKE2
- Rancher
- Helm

## What are these?

### RKE2

RKE2 is a Kubernetes distribution, designed with a focus on security and compliance

An evolution of RKE1, taking inspiration from the modern deployment model of k3s

![RKE2 diagram](https://docs.rke2.io/assets/images/overview-06f8a098e271952bfe5db78b3a0e9b25.png)

- Kubelet - an *agent* running on each node
- Apiserver - provides the Kubernetes API, all interactions with the cluster using `kubectl` access the API
- Etcd - the datastore for the cluster, accessed by the API, keeps all state (objects) for the cluster - nodes, pods, events etc. 

https://docs.rke2.io/architecture

### Rancher

A Kubernetes management tool to provision and manage multiple clusters adding centralised features such as: a single dashboard for all clusters, user management, API access, continuous delivery (Fleet), and a marketplace of apps.

Rancher runs as a deployment in a dedicated Kubernetes cluster

![Rancher diagram](https://ranchermanager.docs.rancher.com/assets/images/rancher-architecture-rancher-api-server-2743dae746c64cd2ad66711908be4108.svg)

### Helm

A templating tool to manage the deployment of apps in Kubernetes clusters, providing an easy approach to manage and update apps

A *chart* is the equivalent of an app template, the input values provided when installing/upgrading the chart will consistently template and deploy the app

The Rancher install is managed with helm

## What else are we doing?

The second exercise we'll provision a Kubernetes cluster from a fresh SLES node

We will provision an RKE2 cluster in Rancher as a *custom* cluster.. what's that?

### Rancher cluster types

- Custom cluster - provisioned onto nodes that are already running, infrastructure is managed outside of Rancher
  - **Note:** A custom cluster is sometimes refered to as a cluster using existing nodes
- Node driver cluster - infrastructure is provisioned first by Rancher (vSphere, AWS, GCloud Azure, DO etc.), a Kubernetes cluster is then provisioned using the nodes
- Hosted Kubernetes cluster - a managed Kubernetes cluster is provisioned by Rancher (EKS, GKE, AKS, etc.)

Additional links:
- https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup

## Continuous Delivery

The third exercise will use Fleet to deploy an app defined in source control

Fleet is a CI/CD tool to monitor repositories, as changes occur in the repository or environment Fleet will maintain the desired state of the apps

![Fleet diagram](https://fleet.rancher.io/assets/images/fleet-architecture-f708ce634648101dc98f451dcd59fe84.svg)