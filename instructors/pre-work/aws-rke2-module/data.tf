# TODO: Make the Ubuntu OS version configurable
# TODO: Add support for ARM architecture
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

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
}