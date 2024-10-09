# cfl-summit-lab | advanced

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

The issue is known to affect changes in the `deployment-lab` namespace, like creating new deployments

  - Repro the issue using the `deployment-lab` namespace
  - Investigate further to understand the issue
  - Make changes as needed to resolve issues

### 2 - Troubleshoot network issues

All deployments for this lab have been created in the `lab` namespace of your downstream cluster, make changes as needed to resolve the issues

**Note**, there is a test pod available, created by a deployment named `test-pod` that should be used for troubleshooting connectivity

#### 2a - Network issue

- Troubleshoot a connectivity issue with a service and deployment named `lab-a`

#### 2b - Network issue

- Troubleshoot a connectivity issue with a service and deployment named `lab-b`

#### 2c - Network issue

- The Rancher website (rancher.com) is reported to fail from pods in this environment

Why is the website failing?

#### 2d - Network issue

- Troubleshoot a connectivity issue with a service and deployment named `lab-c`

What can be done to resolve this issue?
  
# Bonus Rounds

### 3 - Create a downstream cluster (terraform)

Pre-work:
  - Clone this repo to your downstream cluster node: `git clone https://github.com/rancherlabs/cfl-summit-lab.git`
  - Change directory to the `bonus-downstream-cluster` directory of the cloned repo, `terraform` is preinstalled on the node

1. Update the `terraform.tfvars` file to update the required variables (aws credentials, region, url, token, vpc details etc.)
2. Initialise the terraform modules: `terraform init`
3. Check over the `main.tf` file to understand how it works
4. Create the resources: `terraform apply`

### 5 - Deploy an application using Fleet

Instructions to deploy a webserver using fleet are provided in this link
* https://github.com/rancherlabs/cfl-summit-lab/blob/main/bonus-deploy-an-application-using-fleet/README.md

---

# Cleanup (only if you completed bonus round 3)

```bash
cd bonus-downstream-cluster # if not in the directory
terraform destroy
```

---

# !! Instructors only !!

See `pre-work` directory for preparation of the initial lab environment
