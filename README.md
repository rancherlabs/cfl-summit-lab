# cfl-summit-lab

## Lab objectives:

In this lab session we will aim to: 

1. Install Rancher on an RKE2 node
3. Create a downstream RKE2 cluster using the Rancher2 Terraform Provider
4. Deployment of an application using Fleet (we could have a git repo created already with the manifests)

## Lab steps

### Pre-work

- Obtain your node IP and private SSH key from the instructor, this will be your node to use throughout the lab session
- Once logged in, (**TBD** maybe fork first (for use with step 3 - fleet)) clone this repository to the node for use later in the session:
  ```bash
  git clone https://xxxx
  ```

### 1 - Install Rancher

- Steps TBA

https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/install-upgrade-on-a-kubernetes-cluster#install-the-rancher-helm-chart

### 2 - Create a downstream cluster

### 3 - Deploy an application using Fleet

---

# Instructors only

See `pre-work` directory for preparation of the initial lab environment

Notes:
  - Attendees should SSH into their node to get/use the RKE2 kubeconfig, this can be used as a local environment for the session
  - Nodes will be launched with RKE2 running, git and helm will be installed. Shortcuts like `k` are in place to use kubectl