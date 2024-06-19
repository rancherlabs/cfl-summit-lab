
attendees = 1 # change to the number of attendees, this will launch 2x EC2 instances per attendee (one for each rancher/downstream exercise)

prefix = "cfl-lab" # a prefix for all resources created

aws_region = "us-west-2" # change to a region closer to the event if desired

# Only if you want to set long term access keys. If no keys or environment variables are set, the ~/.aws/credentials file will be used
# aws_access_key = ""
# aws_secret_key = ""

# Only use while testing
spot_instances = true