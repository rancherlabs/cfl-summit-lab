
attendees = 1 # change to the number of attendees, this will launch 2x EC2 instances per attendee (one for each rancher/downstream exercise)

prefix = "test-lab" # a common name tag given to all resources created

aws_region = "us-west-2" # change to a region closer to the event if desired

# Only if you want to set long term access keys. If no keys or environment variables are set, the ~/.aws/credentials file will be used
# aws_access_key = ""
# aws_secret_key = ""

# EC2 instance type to use for the Rancher local cluster
rancher_instance_type = "t3a.xlarge"
downstream_instance_type = "t3a.medium"

rancher_password = "initial-admin-password"

# Only use while testing
# spot_instances = true