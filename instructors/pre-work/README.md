# Pre-work

Create the instances that will be used by attendees, applying the terraform will create:
  - 1 x EC2 instance with RKE2 & Rancher preinstalled, this instance has an `r` in the name. Shortcuts like `k` are in place to use kubectl
  - 1 x EC2 instance for each attendee with RKE2 preinstalled, this will be added to the Rancher environment above as an imported cluster

Instances will be launched in the default VPC of the region, with a unique security group and generated SSH key. SLES 15 SP5 is used by default, with SSH username: `ec2-user`

Notes:
  - Attendees are to be given the SSH keys and node IPs - they should pick a number for their lab and use the associated IPs/keys (eg, choose #4 and use `4-cfl-lab`)
  - A slack channel should be created for each event so that attendees can join, the keys and IPs can be shared in the slack channel. Each attendee can drop their chosen number into a thread to avoid conflicts

## Steps

1. If you haven't already, clone this repo
1. Login to Okta and click on "AWS Landing Zone" to generate temporary AWS credentials
   1. Select the "Support Engineering" AWS account drop down
   2. Click the "Access keys" button and copy the contents from the code block in Option 1 to export the variables on your command line, these credentials will be valid for ~12 hours
2. **Alternatively**, terraform will default to the credentials from your `~/.aws/credentials` file, so you can use long-lived credentials there, or stored in the `terraform.tfvars` file as well
3. Terraform:
   1.  Check the terraform.tfvars file to adjust as needed, for eg: the region
   2. `terraform init`
   3. `terrform apply`
4. The output from `terraform apply` will provide a list of node IPs and SSH private keys, to show this again, use `terraform output`
   1. Example:
      ```
      Outputs:

      downstream-node-ips = [
        "1-ds-test-lab: 52.11.106.226",
      ]
      downstream-node-keys = [
        "1-ds-test-lab: 1-ds-test-lab-ssh_private_key.pem",
      ]
      rancher-hostname = "18.246.252.205.nip.io"
      rancher-node-ip = [
        "18.246.252.205",
      ]
      rancher-node-key = "test-lab-rancher-cluster-ssh_private_key.pem"
      ssh-username = "ec2-user"
      ```
5. Distribute the list of IPs and keys to attendees, each attendee should reserve a number (eg, X-cfl-lab) and use the associated IPs/keys throughout the lab.

## Cleanup

It's important to clean up the environment once the lab has finished and attendees no longer want their nodes

1. As in step 4 above, retrieve AWS credentials again (ignore if you took an alternative approach)
2. Terraform:
   1. `terraform destroy`