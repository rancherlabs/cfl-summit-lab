# Pre-work | Step 1

This creates the instances that will be used by attendees on Step 1 to deploy Rancher on a single node RKE2 cluster

## Steps

1. If you haven't already, clone this repo
2. Login to Okta, click on "AWS Landing Zone"
3. Select the "Support Engineering" AWS account drop down
4. Click the "Access keys" button and copy the contents from Option 1 to export the variables, these credentials will be valid for ~12 hours
   1. Alternatively, you can hard code long-lived credentials in the terraform.tfvars file
5. Terraform:
   1. `terraform init`
   2. `terrform apply`
6. The output from `terraform apply` will provide a list of node IPs and SSH privates keys, to show this again, use `terraform output`.
7. Distribute the list of IPs and keys to attendees, each attendees can have a number (eg, cfl-X) and use the associated IP/key as their node.

## Cleanup

It's important to clean up the environment once the lab has finished and attendees no longer want their nodes

1. As in step 4 above, retrieve AWS credentials again (if you didn't hard code them in terraform.tfvars file)
2. Terraform:
   1. `terraform destroy`