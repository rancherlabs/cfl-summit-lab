# Get latest SLES 15 SP5 AMI
data "aws_ami" "suse" {
  most_recent = true
  owners      = ["013907871322"] # Amazon
  filter {
    name   = "name"
    values = ["suse-sles-15-sp5-v*-hvm-ssd-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  name_regex = "suse-sles-15-sp5-v[[:digit:]]*-hvm-ssd-x86_64"
}