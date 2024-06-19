# Pre-work

Create the instances that will be used by attendees in exercise 1 & 2 to deploy Rancher and a downstream cluster, follow the steps below to create the instances.

What will be created for each attendee:
  - 1 x EC2 instance with RKE2 preinstalled, this has a `r` in the name (exercise 1). Git and helm will be installed. Shortcuts like `k` are in place to use kubectl
  - 1 x EC2 instance to use when provisioning a downstream custom cluster, thish has `ds` in the name (exercise 2)

Instances will be launched in the default VPC of the region, with a unique security group and generated SSH key. SLES 15 SP5 is used by default, with SSH username: `ec2-user`

Notes:
  - Attendees are to be given the SSH keys and node IPs. A slack channel should be created for each event so that attendees can join, the keys and IPs can be shared in the slack channel.
  - Attendees should pick a number for their lab and use the associated IPs/keys (eg, choose #4 and use `cfl-lab-ds-4` and `cfl-lab-r-4`). Perhaps a thread in the channel where attendees can enter the number they choose to avoid conflicts?

## Steps

1. If you haven't already, clone this repo
1. Login to Okta and click on "AWS Landing Zone" to generate temporary AWS credentials
   1. Select the "Support Engineering" AWS account drop down
   2. Click the "Access keys" button and copy the contents from the code block in Option 1 to export the variables on your command line, these credentials will be valid for ~12 hours
2. **Alternatively**, terraform will default to the credentials from your `~/.aws/credentials` file, or you can hard code long-lived credentials in the `terraform.tfvars` file
3. Terraform:
   1. `terraform init`
   2. `terrform apply`
4. The output from `terraform apply` will provide a list of node IPs and SSH private keys, to show this again, use `terraform output`
   1. Example:
      ```
      Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

      Outputs:

        downstream-node-ips  = [
            (known after apply),
          ]
        downstream-node-keys = [
            "1-ds-cfl-lab: 1-ds-cfl-lab-ssh_private_key.pem",
          ]
        rancher-node-ips     = [
            (known after apply),
          ]
        rancher-node-keys    = [
            "1-r-cfl-lab: 1-r-cfl-lab-ssh_private_key.pem",
          ]
        ssh-username         = "ec2-user"
      ```
5. Distribute the list of IPs and keys to attendees, each attendee should reserve a number (eg, cfl-X) and use the associated IPs/keys throughout the lab.

## Cleanup

It's important to clean up the environment once the lab has finished and attendees no longer want their nodes

1. As in step 4 above, retrieve AWS credentials again (ignore if you took an alternative approach)
2. Terraform:
   1. `terraform destroy`