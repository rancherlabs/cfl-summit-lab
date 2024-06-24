###### !! Required variables !! ######

## -- AWS access/secret keys - credentials OR an existing ID must be set to create/use a cloud credential in Rancher
# aws_access_key = "ACCESS_KEY_HERE"
# aws_secret_key = "SECRET_KEY_HERE"
aws_access_key = "xxxx"
aws_secret_key = "yyyy"
## OR
# cloud_credential_id = "cattle-global-data:cc-xxx"

## -- AWS region to create the resources, uncomment one or adjust as needed
# aws_region = "us-east-1"         # US, Virginia
aws_region = "us-west-2"         # US, Oregon
# aws_region = "eu-west-1"         # EU, Ireland
# aws_region = "eu-west-1"         # EU, Frankfurt
# aws_region = "ap-southeast-2"    # AU, Sydney
# aws_region = "ap-south-1"        # IN, Mumbai

# Enter the Rancher server URL
rancher_url = "https://xxxx"

# Enter the Rancher API (bearer) token
rancher_token = "token-xxxxx:yyyyy"

# Cluster name
cluster_name = "<name here>-cfl-lab"

# cp_node_pool_name = "cp"
# worker_node_pool_name = "w"
# cp_count = 1
# worker_count = 1
spot_instances = true  # will use spot instances for this lab

# Enter an existing VPC ID in the same region
vpc_id = "vpc-xxxx"

# Enter an existing subnet ID in the same region
subnet_id = "subnet-xxxx"

# Enter the zone letter for this subnet, eg: us-west-2a
zone = "a"

# Enter an existing security group _name_ to use (not ID sg-*) from the same VPC
security_group_name = "1-r-cfl-lab-allow-nodes"

# Kubernetes version (must be supported by Rancher version) for the RKE2/k3s cluster
# https://github.com/rancher/rke2/tags
# https://github.com/k3s-io/k3s/tags
kubernetes_version = "v1.28.10+rke2r1"

###### !! Optional variables !! ######

# AMI you want to use
# ami = "ami-xxxx" # Replace with your desired AMI ID
# Note, you can find all SLES AMIs in your region with the following command:
# aws ec2 describe-images --owners amazon --filters "Name=name,Values=suse-sles-15-sp5-v*-hvm-ssd-x86_64" "Name=virtualization-type,Values=hvm"  --query 'Images[?!contains(Name, `-ecs-`)][].[ImageId, Name]' --output table --region us-west-2 # replace the region name as needed

# SSH username
# ssh_user = "ec2-user" # Replace with your SSH user - it must match the user expected with the AMI

# Enter the EC2 instance type
# instance_type = "t3a.medium"

# Specify root volume size (GB)
# volume_size = "20"

# cni_provider = "calico"

# rancher_insecure = true # Allow insecure connections to Rancher