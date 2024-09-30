# cfl-summit-lab

## Lab objectives:

In this lab session we will aim to complete three lab exercises using a pre-created Rancher and downstream cluster environment: 

1. Troubleshoot an unknown issue
2. Troubleshoot several network issues
3. Review a log collection

## Lab steps

### Pre-work

- You will be provided:
  - A Rancher hostname and credentials
  - A cluster name and private SSH key to use throughout the lab session
    - **SSH username**: `ec2-user`
    - `sudo` is available once logged in

### 1 - Troubleshoot an unknown issue

The issue is known to affect deployments in the `deployment-lab` namespace.

  - Repro the issue by creating a deployment in the `deployment-lab` namespace
  - Investigate further to understand the issue

### 2 - Troubleshoot network issues

# Bonus Rounds

### 3 - Create a downstream cluster (terraform)

Pre-work:
  - Clone this repo to your downstream cluster node: `git clone https://github.com/rancherlabs/cfl-summit-lab.git`
  - Change directory to the `bonus-downstream-cluster` directory of the cloned repo, `terraform` is preinstalled on the node

1. Update the `terraform.tfvars` file to update the required variables (aws credentials, region, url, token, vpc details etc.)
2. Initialise the terraform modules: `terraform init`
3. Create the resources: `terraform apply`

### 4 - Deploy an application using Fleet

Instructions to deploy a webserver using fleet are provided in this link
* https://github.com/rancherlabs/cfl-summit-lab/blob/main/bonus-deploy-an-application-using-fleet/README.md

---

# Cleanup (only if you completed exercise 3)

```bash
cd bonus-downstream-cluster # if not in the directory
terraform destroy
```

---

# Instructors only

See `pre-work` directory for preparation of the initial lab environment
