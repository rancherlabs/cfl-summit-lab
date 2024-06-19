# cfl-summit-lab

## Lab objectives:

In this lab session we will aim to complete three exercises: 

1. Install Rancher on an RKE2 cluster
2. Provision a downstream RKE2 cluster using Rancher
3. Deploy an application using Fleet

Bonus rounds:
4. Take an etcd snapshot of the downstream cluster
5. Deploy an application using the HelmChart controller
6. Restore the etcd snapshot taken in 4. to revert the app deployment

## Lab steps

### Pre-work

- Obtain your node IPs and private SSH keys from the instructor, these will be your nodes to use throughout the lab session
  - There are two node IPs and private key files:
    - The node with `r` is the Rancher node used in exercise 1
    - The node with `ds` is the downstream node used in exercise 2

### 1 - Install Rancher

Navigate to the Rancher install guide in the link below:
  * https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/install-upgrade-on-a-kubernetes-cluster#install-the-rancher-helm-chart

1. SSH into the node (with `r` in the name)
2. Follow the steps to add the helm repo and create the `cattle-system` namespace. Choose the `latest` helm repository
3. From step 3 onwards, in this lab the "Rancher-generated TLS certificate" approach is recommended, where cert-manager will need to be installed (step 4)
4. For step 5, a hostname is needed for Rancher. You can use your own custom domain name, however for lab purposes, it is recommended to generate a quick hostname with `.nip.io`, just append this to your Rancher node Public IP: eg, `5.6.7.8.nip.io`
   1. If you are unsure about the Public IP, use: `curl ifconfig.io` from the command line on the node
   2. Use this hostname for the `--set hostname` flag when running `helm install`, eg: `--set hostname=5.6.7.8.nip.io`
   3. Supply a bootstrap password to use when logging into Rancher for the first time with the `--set bootstrapPassword` flag
   4. Replace the `<CHART_REPO>` portion of the `helm install` command with `latest`, if latest was the repo chosen in the first step of this exercise


### 2 - Create a downstream cluster

Navigate to the Downstream cluster configuration guide in the link below:
  * https://ranchermanager.docs.rancher.com/reference-guides/cluster-configuration/rancher-server-configuration/use-existing-nodes

1. SSH into the node (with `ds` in the name)
2. Follow the steps in the configuration guide (link above) from step 2 (Create the Custom Cluster)
3. At the end of step 2 you will use this node (with `ds` in the name) to run the provisioning command
4. Step 3 (Tag Resources) can be ignored

### 3 - Deploy an application using Fleet

- Details TBA

---

# Instructors only

See `pre-work` directory for preparation of the initial lab environment
